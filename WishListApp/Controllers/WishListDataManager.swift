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
        guard let viewContext = self.persistentContainer?.viewContext else {
            print("Error: Can't access Core Data view context")
            return
        }

        let newWishData = WishListData(context: viewContext)

        newWishData.id = wishData.getId()
        newWishData.name = wishData.getName()
        newWishData.descriptions = wishData.getDescriptions()
        newWishData.price = wishData.getPrice()
        newWishData.thumbnail = wishData.getThumbnail()

        do {
            try viewContext.save()
            print("Data saved successfully")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }

    
    func readData() -> [WishListData] {
        guard let viewContext = self.persistentContainer?.viewContext else {
            print("Error: Can't access Core Data view context")
            return []
        }
        
        let request = WishListData.fetchRequest()
        
        do {
            let wishListDatas = try viewContext.fetch(request)
            return wishListDatas
        } catch {
            print("Error fetching data from CoreData: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteData(at index: Int) {
        guard let viewContext = self.persistentContainer?.viewContext else {
            print("Error: Can't access Core Data view context")
            return
        }
        
        let request = WishListData.fetchRequest()
        
        do {
            let wishListDatas = try viewContext.fetch(request)
            // 인덱스 유효성 검사
            guard wishListDatas.indices.contains(index) else {
                print("Error: Index out of range")
                return
            }
            // 인덱스에 해당하는 데이터 삭제
            let dataToDelete = wishListDatas[index]
            viewContext.delete(dataToDelete)
            
            // 변경 사항 저장
            try viewContext.save()
            print("Data deleted successfully")
        } catch {
            print("Failed to delete data: \(error.localizedDescription)")
        }
    }
}
