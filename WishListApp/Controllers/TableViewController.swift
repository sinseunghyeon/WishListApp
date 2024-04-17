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
        
        // UITableViewController의 기존 refreshControl 프로퍼티를 직접 사용합니다.
        if let refreshControl = tableView.refreshControl {
            refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
            refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        } else {
            let newRefreshControl = UIRefreshControl()
            newRefreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
            newRefreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
            tableView.refreshControl = newRefreshControl
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = wishListDatas[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedPrice = formatter.string(from: NSNumber(value: data.price)),
           let unwrapName = data.name {
            cell.textLabel?.text = "[\(data.id)] \(unwrapName) - \(formattedPrice) $"
        } else {
            cell.textLabel?.text = "[\(data.id)] \(data.name ?? "None") - \(data.price) $"
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wishListDatas.remove(at: indexPath.row)
            wishListDataManager.deleteData(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        self.wishListDatas = self.wishListDataManager.readData()
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
}
