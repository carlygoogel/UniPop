//
//  FeedViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/12/24.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
   // @Published var posts = [Post]()
    @Published var categorizedPosts: [(category: String, posts: [Post])] = []
    @Published var isLoading = true
    private var allPosts: [Post] = []
    private let postsPerCategory = 10


    init() {
        Task {  await fetchPosts() }
        // Task { try await fetchPosts() }
    }

    @MainActor
//    func fetchPosts() async throws {
//        self.posts = try await PostService.fetchFeedPosts()
//        groupPostsByCategory()
//    }

    func fetchPosts() async {
        isLoading = true
        do {
            allPosts = try await PostService.fetchFeedPosts()
            updateCategorizedPosts()
            isLoading = false
        } catch {
            print("Error fetching posts: \(error)")
            isLoading = false
        }
    }

    @MainActor
    func refreshPosts() async {
        do {
            allPosts = try await PostService.fetchFeedPosts()
            updateCategorizedPosts()
        } catch {
            print("Error refreshing posts: \(error)")
        }
    }

    private func updateCategorizedPosts() {
        let grouped = Dictionary(grouping: allPosts) { $0.category ?? "Uncategorized" }

        // Create a new ordered dictionary
        var orderedCategories: [(String, [Post])] = []

        if let trending = grouped["Trending"] {
            orderedCategories.append(("Trending", trending))
        }
        
        // Add "Hot outfits" second if it exists
        if let hotOutfits = grouped["Hot outfits"] {
            orderedCategories.append(("Hot outfits", hotOutfits))
        }


        // Add "Cool items" first if it exists
        if let coolItems = grouped["Cool items"] {
            orderedCategories.append(("Cool items", coolItems))
        }

        if let greekLife = grouped["Greek life"] {
            orderedCategories.append(("Greek life", greekLife))
        }

        // Add the rest of the categories
        for (category, posts) in grouped {
            if category != "Trending" && category != "Cool items" && category != "Hot outfits" && category != "Greek life" {
                orderedCategories.append((category, posts))
            }
        }

        // Convert back to a dictionary
        self.categorizedPosts = orderedCategories

    }

    func loadMorePosts(for category: String) {
        guard let index = categorizedPosts.firstIndex(where: { $0.category == category }) else { return }
        let currentPosts = categorizedPosts[index].posts
        let allCategoryPosts = allPosts.filter { $0.category == category }

        if currentPosts.count < allCategoryPosts.count {
            let newPosts = Array(allCategoryPosts[currentPosts.count..<min(currentPosts.count + postsPerCategory, allCategoryPosts.count)])
            categorizedPosts[index].posts.append(contentsOf: newPosts)
        }
    }

}
