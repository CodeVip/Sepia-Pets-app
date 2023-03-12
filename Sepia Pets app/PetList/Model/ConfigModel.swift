//
//  ConfigModel.swift
//  Sepia Pets app
//
//  Created by vipin on 3/11/23.
//

import Foundation

struct ConfigModel: Codable {
    let settings: Settings
}

// MARK: - Settings
struct Settings: Codable {
    let workHours: String
}
