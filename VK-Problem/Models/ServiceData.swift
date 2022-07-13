//
//  DataModel.swift
//  VK-Problem
//
//  Created by Fed on 13.07.2022.
//

import Foundation

struct ServiceData: Codable {
    
    let body: Services
}

struct Services: Codable {
    let services: [ArrayOfService]
    
}

struct ArrayOfService: Codable {
    let name: String
    let description: String
    let link: String
    let icon_url: String
}
