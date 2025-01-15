//
//  UserListViewModel.swift
//  PersonBook
//
//  Created by gizem on 15.01.2025.
//
// UserListViewModel.swift

import Foundation

class UserListViewModel {
    
    private let repository: UserRepositoryProtocol
    
    var users: [User] = []
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    // This is used to fetch the user details for a particular row in the table view
    func getUser(at index: Int) -> User {
        return users[index]
    }
    
    // A function to fetch users -> uses a closure to handle the success or failure of the network call
    func fetchUsers(completion: @escaping (Bool) -> Void) {
        repository.fetchUsers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedUsers):
                self.users = fetchedUsers
                print(self.users)
                completion(true)
            case .failure(let error):
                self.handleError(error)
                completion(false)
            }
        }
    }
    
    // This is used to update the table view when new users are fetched
    var numberOfUsers: Int {
        return users.count
    }
    
    private func handleError(_ error: NetworkError) {
        switch error {
        case .badURL:
            print("Invalid URL")
        case .requestFailed:
            print("Network request failed")
        case .invalidResponse:
            print("Invalid server response")
        case .decodingError:
            print("Failed to decode data")
        }
    }
    
}
