//
//  UserService.swift
//  PersonBook
//
//  Created by gizem on 15.01.2025.
//

import Foundation

class UserService {
    
    static let shared = UserService()
    
    private init() {}

    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
