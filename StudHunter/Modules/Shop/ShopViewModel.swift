//
//  ShopViewModel.swift
//  StudHunter
//
//  Created by Антон Сетямин on 16.02.2023.
//

import Foundation

class ShopViewModel: ObservableObject{
    @Published var products: [ProductModel] = []
    private let dataService = productDataService.shared
    
    init(){
        getProducts()
    }
    //upload product data
    func uploadProductData(product:ProductModel){
        dataService.uploadProductData(product: product) { result in
            switch result{
            case .success(let product):
                print("Succsessfully upload data\(product.id)")
            case .failure(let error):
                print("Error uploaded peoductData\(product.id) : \(error.localizedDescription)")
            }
        }
    }
    
    private func getProducts(){
        let product1 = ProductModel(id: "123", article: "1234", brands: .brand1, name: "cat 1", description: "хороший котик", image: "1", cost: 12, date: "29 декабря 20:59", location: "Общежитие 2")
        let product2 = ProductModel(id: "1234", article: "1234", brands: .brand2, name: "cat 2", description: "классный котик", image: "2", cost: 10, date: "30 декабря 20:59", location: "Общежитие 6")
        let product3 = ProductModel(id: "1235", article: "1234", brands: .brand3, name: "cat 3", description: "просто котик", image: "3", cost: 100, date: "31 декабря 20:59", location: "Общежитие 2")
        
        products.append(contentsOf: [
        product1,
        product2,
        product3
        ])
    }
}
