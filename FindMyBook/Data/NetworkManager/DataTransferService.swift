//
//  APIClient.swift
//  FindMyBook
//
//  Created by gokul v on 01/07/25.
//

import Foundation

protocol DataTransferService {
    func request<T: Decodable>(urlPath: String, completion: @escaping (Result<T, Error>) -> Void)
}

class DefaultDataTransferService: DataTransferService {
    func request<T>(urlPath: String, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        guard let url = URL(string: urlPath) else { return }

        var request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, result, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                print("Data Error")
                return
            }
            do {
                let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(jsonResponse))
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
        task.resume()
    }
}
