//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Yerkebulan on 28.01.2025.
//

import SwiftUI
import Combine

class NetworkManager {
    
    public static let shared = NetworkManager()
    
    private init () {}
    
    public func download(url: URL) -> Publishers.ReceiveOn<Publishers.TryMap<Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>, Data>, DispatchQueue> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap{ (output) -> Data in
                guard let responce = output.response as? HTTPURLResponse, responce.statusCode >= 200 && responce.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
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
