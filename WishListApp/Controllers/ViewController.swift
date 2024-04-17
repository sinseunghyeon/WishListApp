//
//  ViewController.swift
//  WishListApp
//
//  Created by t2023-m0056 on 4/15/24.
//

import UIKit

class ViewController: UIViewController {
    
    let networkManager = NetworkManager()
    let wishListDataManager = WishListDataManager()
    var currentWishData: WishData?
    
    var randomNumber = Int.random(in: 1..<100)
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
        self.setNetwork()
    }
    
    private func setNetwork() {
        networkManager.fetchProducts(id: randomNumber) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let wishData):
                    print("Success")
                    self?.setUISubStackView(wishData)
                    self?.currentWishData = wishData
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        networkManager.downloadImage(id: randomNumber) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let uiImage):
                    print("Success")
                    self?.setUIStackView(uiImage)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension ViewController {

    func setUIStackView(_ image: UIImage) {
        view.addSubview(uiStackView)
        uiStackView.addArrangedSubview(uiImageView)
        uiImageView.image = image
        uiStackView.addArrangedSubview(uiSubStackView)
        
        uiStackView.axis = .vertical
        uiStackView.spacing = 5
        uiStackView.distribution = .fillEqually
        uiStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uiStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            uiStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            uiStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            uiStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setUISubStackView(_ wishData: WishData) {
        uiSubStackView.axis = .vertical
        uiSubStackView.spacing = 10
        uiSubStackView.distribution = .fillEqually
        uiSubStackView.isLayoutMarginsRelativeArrangement = true
        uiSubStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        uiSubStackView.addArrangedSubview(uiTitleLabel)
        uiTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        uiTitleLabel.text = wishData.getName()
        
        uiSubStackView.addArrangedSubview(uiDescriptionLabel)
        uiDescriptionLabel.text = wishData.getDescriptions()
        
        uiSubStackView.addArrangedSubview(uiPriceLabel)
        uiPriceLabel.text = String(wishData.getPrice()) + " $"
        
        uiSubStackView.addArrangedSubview(uiHorizonStackView)
        uiHorizonStackView.axis = .horizontal
        uiHorizonStackView.spacing = 20
        uiHorizonStackView.distribution = .fillEqually
        
        uiHorizonStackView.addArrangedSubview(uiAddButton)
        uiAddButton.backgroundColor = .green
        uiAddButton.setTitle("위시 리스트 담기", for: .normal)
        uiAddButton.layer.cornerRadius = 20
        uiAddButton.addTarget(self, action: #selector(tapUIAddButton), for: .touchUpInside)
        
        uiHorizonStackView.addArrangedSubview(uiOtherButton)
        uiOtherButton.backgroundColor = .red
        uiOtherButton.setTitle("다른 상품 보기", for: .normal)
        uiOtherButton.layer.cornerRadius = 20
        uiOtherButton.addTarget(self, action: #selector(tapUIOtherButton), for: .touchUpInside)
        
        uiSubStackView.addArrangedSubview(uiWishListButton)
        uiWishListButton.backgroundColor = .gray
        uiWishListButton.setTitle("위시 리스트 보기", for: .normal)
        uiWishListButton.layer.cornerRadius = 20
        uiWishListButton.addTarget(self, action: #selector(tapUIWishListButton), for: .touchUpInside)
    }
    
    @objc func tapUIAddButton() {
        if let wishData = currentWishData {
            wishListDataManager.createData(wishData: wishData)
        }
    }
    
    @objc func tapUIOtherButton() {
        randomNumber = Int.random(in: 1...100)
        setNetwork()
    }
    
    @objc func tapUIWishListButton() {
        // NextViewController를 가져옵니다.
        let storyboard = UIStoryboard(name: "TableView", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "TableView")
          
        // PresentationStyle을 지정합니다.
        self.modalPresentationStyle = .fullScreen
          
        // NextViewController를 present 합니다.
        self.present(nextVC, animated: true)
    }
}
