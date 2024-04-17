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
        self.setTableView()
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = wishListDatas[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "[\(data.id)] \(data.name!) - \(data.price) $"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wishListDatas.remove(at: indexPath.row)
            wishListDataManager.deleteData(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
