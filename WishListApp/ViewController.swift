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
    var uiStackView = UIStackView()
    var uiImageView = UIImageView()
    var uiSubStackView = UIStackView()
    var uiTitleLabel = UILabel()
    var uiDescriptionLabel = UILabel()
    var uiPriceLabel = UILabel()
    var uiHorizonStackView = UIStackView()
    var uiAddButton = UIButton()
    var uiOtherButton = UIButton()
    var uiWishListButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUIStackView()
        setUISubStackView()
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

extension ViewController {

    func setUIStackView() {
        view.addSubview(uiStackView)
        uiStackView.addArrangedSubview(uiImageView)
        uiImageView.backgroundColor = .yellow
        uiStackView.addArrangedSubview(uiSubStackView)
        uiSubStackView.backgroundColor = .white
        
        uiStackView.axis = .vertical
        uiStackView.spacing = 5
        uiStackView.distribution = .fillEqually
        uiStackView.backgroundColor = .blue
        uiStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uiStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            uiStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            uiStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            uiStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setUISubStackView() {
        uiSubStackView.axis = .vertical
        uiSubStackView.spacing = 10
        uiSubStackView.distribution = .fillEqually
        uiSubStackView.isLayoutMarginsRelativeArrangement = true
        uiSubStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        uiSubStackView.addArrangedSubview(uiTitleLabel)
        uiTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        uiTitleLabel.text = "Product Name"
        
        uiSubStackView.addArrangedSubview(uiDescriptionLabel)
        uiDescriptionLabel.text = "Product Description"
        
        uiSubStackView.addArrangedSubview(uiPriceLabel)
        uiPriceLabel.text = "$100"
        
        uiSubStackView.addArrangedSubview(uiHorizonStackView)
        uiHorizonStackView.axis = .horizontal
        uiHorizonStackView.spacing = 20
        uiHorizonStackView.distribution = .fillEqually
        
        uiHorizonStackView.addArrangedSubview(uiAddButton)
        uiAddButton.backgroundColor = .green
        uiAddButton.setTitle("위시 리스트 담기", for: .normal)
        uiAddButton.layer.cornerRadius = 20
        
        uiHorizonStackView.addArrangedSubview(uiOtherButton)
        uiOtherButton.backgroundColor = .red
        uiOtherButton.setTitle("다른 상품 보기", for: .normal)
        uiOtherButton.layer.cornerRadius = 20
        
        uiSubStackView.addArrangedSubview(uiWishListButton)
        uiWishListButton.backgroundColor = .gray
        uiWishListButton.setTitle("위시 리스트 보기", for: .normal)
        uiWishListButton.layer.cornerRadius = 20
    }
}
