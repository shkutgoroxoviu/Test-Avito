//
//  List.swift
//  TestovoeAvito
//
//  Created by Oleg on 17.06.2023.
//

import Foundation


struct Response: Codable {
    let status: String
    let result: Result
}

struct Result: Codable {
    let title: String
    let actionTitle: String
    let selectedActionTitle: String
    let list: [ListItem]
}

struct ListItem: Codable {
    let id: String
    let title: String
    let description: String
    let icon: Icon
    let price: String
    let isSelected: Bool
}

struct Icon: Codable {
    let iconUrl: String
    
    enum CodingKeys: String, CodingKey {
        case iconUrl = "52x52"
    }
}

