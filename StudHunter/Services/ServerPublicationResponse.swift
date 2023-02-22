//
//  ServerPublicationResponse.swift
//  StudHunter
//
//  Created by Антон Плотников on 10.08.2023.
//

import Foundation
import SwiftUI

class DataFetcher: ObservableObject {
    @Published var selectedCategories: [String] = [""]
    @Published var selectedPriceType: [String] = [""]
    @Published var selectedLocation: [String] = [""]
    
    @Published var data: [Int:String] = [:]
    

        func takeCategoies(){
            let request = URLRequest(url: URL(string: "http://5.181.255.253/publication/categories")!)
    
            let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
                if let error = error{
                    print(error)
                    return
                }
                guard let data = data else {debugPrint("mwcmwc"); return}
                do{
                    let data = try JSONDecoder().decode([Int:String].self, from: data)
                    let newData = data.sorted {$0.key < $1.key}
                    selectedCategories = newData.map { (key: Int, value: String) in
                        value
                    }
                    debugPrint(selectedCategories)
    
                }catch{
                  print(error)
                }
    
            }.resume()
    
        }
    
    func takeLocation(){
        let request = URLRequest(url: URL(string: "http://5.181.255.253/publication/districts")!)

        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if let error = error{
                print(error)
                return
            }
            guard let data = data else {debugPrint("mwcmwc"); return}
            do{
                selectedLocation = try JSONDecoder().decode([String].self, from: data)

                debugPrint(selectedLocation)

            }catch{
              print(error)
            }
        }.resume()
    }
    
    func takePriceType(){
        let request = URLRequest(url: URL(string: "http://5.181.255.253/publication/priceTypes")!)

        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if let error = error{
                print(error)
                return
            }
            guard let data = data else {debugPrint("mwcmwc"); return}
            do{
                let data = try JSONDecoder().decode([Int:String].self, from: data)
                let newData = data.sorted {$0.key < $1.key}
                selectedPriceType = newData.map { (key: Int, value: String) in
                    value
                }
                debugPrint(selectedPriceType)

            }catch{
              print(error)
            }

        }.resume()

    }
}


