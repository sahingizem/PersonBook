//
//  User.swift
//  PersonBook
//
//  Created by gizem on 15.01.2025.
//

import Foundation

struct User: Codable {
    
    let id: Int
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    let address: Address?
    
}
