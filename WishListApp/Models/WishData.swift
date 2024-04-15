//
//  WishData.swift
//  WishListApp
//
//  Created by t2023-m0056 on 4/15/24.
//

import Foundation

struct WishData: Decodable {
    private let id: Int
    private let name: String
    private let description: String
    private let price: Int
    private let discountPercentage: Double?
    private let rating: Double
    private let stock: Int
    private let brand: String
    private let category: String?
    private let thumbnail: String?
    private let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case description
        case price
        case discountPercentage
        case rating
        case stock
        case brand
        case category
        case thumbnail
        case image
    }
    
    public func getId() -> Int {
        return id
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getDescription() -> String {
        return description
    }
    
    public func getPrice() -> Int {
        return price
    }
    
    public func getDiscountPercentage() -> Double {
        if let discountPercentage = self.discountPercentage {
            return discountPercentage
        }
        return 0.0
    }
    
    public func getRating() -> Double {
        return rating
    }
    
    public func getStock() -> Int {
        return stock
    }
    
    public func getBrand() -> String {
        return brand
    }
    
    public func getCategory() -> String {
        if let category = self.category {
            return category
        }
        return "None"
    }
    
    public func getThumbnail() -> String {
        if let thumbnail = self.thumbnail {
            return thumbnail
        }
        return "None"
    }
    
    public func getImage() -> String {
        if let image = self.image {
            return image
        }
        return "None"
    }
}
