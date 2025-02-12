//
//  CoinEntity+CoreDataProperties.swift
//  CryptoApp
//
//  Created by Yerkebulan on 09.02.2025.
//
//

import Foundation
import CoreData


extension CoinEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoinEntity> {
        return NSFetchRequest<CoinEntity>(entityName: "CoinEntity")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var id: String?
    @NSManaged public var amount: Double
    @NSManaged public var image: String?

}

extension CoinEntity : Identifiable {

}
