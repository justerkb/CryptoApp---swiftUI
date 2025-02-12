//
//  UserPortfolioViewModel.swift
//  CryptoApp
//
//  Created by Yerkebulan on 09.02.2025.
//

import CoreData

class PortfolioCoinDataService: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var allEntities: [CoinEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "PortfolioContainer")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("SUCCESSFULLY LOADED CORE DATA")
            }
        }
        fetchCoins()
        print(allEntities.count)
    }
    
    //MARK: - FUNCTIONS
    
    public func updatePorfolio(coin: CoinModel, amount: Double) {
        if let entity = allEntities.first(where: { $0.id == coin.id }) {
            
            updateCoin(entity, amount: amount)
            print("SUCSEFULY UPDATED")
        } else {
            addCoin(coin: coin, amount: amount)
            print("SUCSEFULLY ADDED")
        }
        
        
        fetchCoins()
        print(allEntities.count)
        
    }
    public func fetchCoins() {
        let request = NSFetchRequest<CoinEntity>(entityName: "CoinEntity")
        
        do {
            self.allEntities = try container.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func addCoin(coin: CoinModel, amount: Double) {
        let newCoin = CoinEntity(context: container.viewContext)
        
        newCoin.amount = amount
        newCoin.id = coin.id
        saveData()
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
            fetchCoins()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func deleteCoin(_ coin: CoinEntity) {
        container.viewContext.delete(coin)
        saveData()
    }
    
    private func updateCoin(_ coin: CoinEntity, amount: Double) {
        coin.amount = amount
        saveData()
    }
}
