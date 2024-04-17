//
//  WishListDataManager.swift
//  WishListApp
//
//  Created by t2023-m0056 on 4/17/24.
//

import CoreData
import UIKit

class WishListDataManager {
    
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    func createData(wishData: WishData) {
        
        guard let wishListData = self.persistentContainer?.viewContext else {
            return
        }

        let newWishData = WishListData(context: wishListData)

        newWishData.id = wishData.getId()
        newWishData.name = wishData.getName()
        newWishData.descriptions = wishData.getDescriptions()
        newWishData.price = wishData.getPrice()
        newWishData.thumbnail = wishData.getThumbnail()

        print(newWishData)
        try? wishListData.save()
    }
    
    func readData() -> [WishListData] {
        
        if let wishListData = self.persistentContainer?.viewContext {
            
            let request = WishListData.fetchRequest()
            
            if let wishListDatas = try? wishListData.fetch(request) {
                return wishListDatas
            }
        } else {
            print("Error: Can't read Core Data")
        }
        return []
    }
    
    func deleteData(indexPath: Int) {
        
        guard let wishListData = self.persistentContainer?.viewContext else {
            return
        }

        let request = WishListData.fetchRequest()

        guard let wishListDatas = try? wishListData.fetch(request) else {
            return
        }

//        let filteredCars = wishListDatas.filter({ $0.name == "tesla" })

//        wishListData.delete(wishListData[indexPath])

        try? wishListData.save()
    }
}
