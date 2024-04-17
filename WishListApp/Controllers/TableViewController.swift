//
//  UITableViewController.swift
//  WishListApp
//
//  Created by t2023-m0056 on 4/17/24.
//

import UIKit

class TableViewController: UITableViewController {
    let wishListDataManager = WishListDataManager()
    var wishListDatas: [WishListData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wishListDatas = self.wishListDataManager.readData()
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wishListDatas = wishListDataManager.readData()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        for data in wishListDatas {
            cell.textLabel?.text = data.name
        }
        
        return cell
    }
}
