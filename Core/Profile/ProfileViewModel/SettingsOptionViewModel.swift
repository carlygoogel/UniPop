//
//  SettingsOptionViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 4/26/24.
//

import Foundation
import SwiftUI

enum SettingsOptionsViewModel: Int, CaseIterable, Identifiable {
    case darkMode
    case activeStatus
    case accessibility
    case privacy
    case notifications

    var title: String {
        switch self {
        case .darkMode: return "Dark mode"
        case .activeStatus: return "Active status"
        case .accessibility: return "Accessility"
        case .privacy: return "Privacy and Safety"
        case .notifications: return "Notifications"
        }
    }

    var imageName: String {
        switch self {
        case .darkMode: return "moon.circle.fill"
        case .activeStatus: return "circle.fill"
        case .accessibility: return "person.circle.fill"
        case .privacy: return "lock.circle.fill"
        case .notifications: return "bell.circle.fill"
        }
    }

    var imageBackgroundColor: Color {
        switch self {
        case .darkMode: return Color.black
        case .activeStatus: return Color(.systemGreen)
        case .accessibility: return Color.black
        case .privacy: return Color(.systemBlue)
        case .notifications: return Color(.systemPurple)
        }
    }

    var id: Int { return self.rawValue }
}

