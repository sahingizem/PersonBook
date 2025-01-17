//
//  UserService.swift
//  PersonBook
//
//  Created by gizem on 15.01.2025.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

class UserService: UserServiceProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        networkManager.request(url: "https://jsonplaceholder.typicode.com/users", completion: completion)
    }
}
