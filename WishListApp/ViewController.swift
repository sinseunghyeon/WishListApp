//
//  ViewController.swift
//  WishListApp
//
//  Created by t2023-m0056 on 4/15/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.fetchProducts(id: 1) { result in
            switch result {
            case .success(let wishData):
                print("Sucess")
                print(wishData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

