//
//  WishData.swift
//  WishListApp
//
//  Created by t2023-m0056 on 4/15/24.
//

import Foundation

struct WishData: Decodable {
    private let id: Int64
    private let name: String
    private let descriptions: String
    private let price: Int64
    private let discountPercentage: Double?
    private let rating: Double?
    private let stock: Int64?
    private let brand: String?
    private let category: String?
    private let thumbnail: String
    private let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case descriptions = "description"
        case price
        case discountPercentage
        case rating
        case stock
        case brand
        case category
        case thumbnail
        case image
    }
    
    public func getId() -> Int64 {
        return self.id
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getDescriptions() -> String {
        return self.descriptions
    }
    
    public func getPrice() -> Int64 {
        return self.price
    }
    
    public func getDiscountPercentage() -> Double {
        if let discountPercentage = self.discountPercentage {
            return discountPercentage
        }
        return 0.0
    }
    
    public func getRating() -> Double {
        if let rating = self.rating {
            return rating
        }
        return 0.0
    }
    
    public func getStock() -> Int64 {
        if let stock = self.stock {
            return stock
        }
        return 0
    }
    
    public func getBrand() -> String {
        if let brand = self.brand {
            return brand
        }
        return "None"
    }
    
    public func getCategory() -> String {
        if let category = self.category {
            return category
        }
        return "None"
    }
    
    public func getThumbnail() -> String {
        return self.thumbnail
    }
    
    public func getImage() -> String {
        if let image = self.image {
            return image
        }
        return "None"
    }
}
