//
//  NetworkManager.swift
//  WishListApp
//
//  Created by t2023-m0056 on 4/16/24.
//

import Foundation
import UIKit

final class NetworkManager {
    let url = "https://dummyjson.com/products/"
    
    func fetchProducts(id: Int, completion: @escaping (Result<WishData, Error>) -> Void) {

        // URL 생성
        guard let url = URL(string: "\(self.url)\(id)") else {
            completion(.failure(NSError()))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // URLSession 인스턴스 생성
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError()))
                return
            }
            
            do {
                let hasData = try JSONDecoder().decode(WishData.self, from: data)
                completion(.success(hasData))
            } catch {
                completion(.failure(error))
            }
        }
            
        // 네트워크 요청 시작
        task.resume()
    }
    
    func downloadImage(id: Int, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let imageUrl = "https://cdn.dummyjson.com/product-images/\(id)/thumbnail.jpg"
        
        guard let imageUrl = URL(string: imageUrl) else {
            completion(.failure(NSError()))
            return
        }
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = "GET"
        
        // URLSession 인스턴스 생성
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError()))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(NSError()))
            }
        }
            
        // 네트워크 요청 시작
        task.resume()
    }
}
