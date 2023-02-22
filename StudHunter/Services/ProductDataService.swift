//
//  ProductDataService.swift
//  StudHunter
//
//  Created by Антон Сетямин on 21.02.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase


class productDataService{
    
    static let shared: productDataService = productDataService()
    
    private let ref = Database.database().reference()
    
    private var producID: DatabaseReference {
        return Database.database().reference().child("products_id")
    }
    private var products: DatabaseReference {
        return Database.database().reference().child("products")
    }
    
    //    func uploadProductData(product: ProductModel, completion: @escaping(Result<ProductModel,Error>) -> Void){
    //        producID.document(product.id).setData([ : ]) { error in
    //            if let error = error{
    //                completion(.failure(error))
    //            }else{
    //                self.products.document(product.id).setData(product.data) { error in
    //                    if let error = error{
    //                        completion(.failure(error))
    //                    }else{
    //                        completion(.success(product))
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    func uploadProductData(product: ProductModel, completion: @escaping(Result<ProductModel,Error>) -> Void) {
        ref.child("products").child(product.id).setValue(product.data) { error,arg    in
            if let error = error {
                completion(.failure(error))
            } else {
                self.ref.child("products").child(product.id).setValue(product.data) { error,arg  in
                    if let error = error{
                        completion(.failure(error))
                    }else{
                        completion(.success(product))
                    }
                }
            }
        }
    }
}
