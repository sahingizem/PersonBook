//
//  NetworkManager.swift
//  PersonBook
//
//  Created by gizem on 16.01.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()

    private init() {}

    func request<T: Decodable>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
