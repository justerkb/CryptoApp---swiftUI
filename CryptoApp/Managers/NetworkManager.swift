//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Yerkebulan on 28.01.2025.
//

import SwiftUI
import Combine

class NetworkManager {
    
    enum NetworkingErrors: String, Error {
        case badURL = "Bad responce from URL"
        case unowned = "Unkown error occurred"
    }
    
    public static let shared = NetworkManager()
    
    private init () {}
    
    public func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap{
                try self.handleUrlResponce(output: $0)
            }
            .receive(on: DispatchQueue.main)
        
            .eraseToAnyPublisher()
    }
    
    public func handleUrlResponce(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let responce = output.response as? HTTPURLResponse, responce.statusCode >= 200 && responce.statusCode < 300 else {
            throw URLError(.badURL)
        }
        return output.data
    }
    
    public func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            print("Error: \(error)")
        case .finished:
            break
        }
    }
    
}
