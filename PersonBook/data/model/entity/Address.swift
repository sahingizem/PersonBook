//
//  Address.swift
//  PersonBook
//
//  Created by gizem on 15.01.2025.
//

import Foundation

struct Address: Codable {
    
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
    
}
