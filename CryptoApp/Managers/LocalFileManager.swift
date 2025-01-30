//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Yerkebulan on 30.01.2025.
//

import Foundation
import SwiftUI

class LocalFileManager {
    public static let shared = LocalFileManager()
    
    private init() {}
    
    func saveImage(image: UIImage) {
        guard let data = image.pngData(),
              let url = URL(string: "")
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func getURLForFolder(name: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        return url.appendingPathComponent(name)
        
    }
}
