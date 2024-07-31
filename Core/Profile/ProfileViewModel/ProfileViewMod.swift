//
//  ProfileViewMod.swift
//  UniPop-App
//
//  Created by Carly Googel on 4/27/24.
//

import Foundation
import SwiftUI
import PhotosUI

class ProfileViewMod: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }

    @Published var ProfileImage: Image?

    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.ProfileImage = Image(uiImage: uiImage)
    }


}
