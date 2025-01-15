//
//  NetworkError.swift
//  PersonBook
//
//  Created by gizem on 15.01.2025.
//

import Foundation

enum NetworkError: Error {
    
    case badURL
    case requestFailed
    case invalidResponse
    case decodingError
    
}
