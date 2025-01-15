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

class UserService : UserServiceProtocol {
    
    static let shared = UserService()
    
    private init() {}

    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Request failed with error: \(String(describing: error?.localizedDescription))")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
