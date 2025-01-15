//
//  UserRepository.swift
//  PersonBook
//
//  Created by gizem on 16.01.2025.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

class UserRepository: UserRepositoryProtocol {

    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol = UserService.shared) {
        self.userService = userService
    }

    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        userService.fetchUsers(completion: completion)
    }
}
