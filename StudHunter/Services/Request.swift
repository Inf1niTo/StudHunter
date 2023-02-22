//
//  Request.swift
//  StudHunter
//
//  Created by Антон Плотников on 02.06.2023.
//

import Foundation
class Requesting: ObservableObject{
    @Published var dataBase:[JSData] = []
    @Published var dataBaseForMyPubs:[MyPublicationsData] = []
    
    
    var profileData: ProfileData!
    var fullCardData: FullCardData!
   // var editProfile: EditProfileRequest!
    
//    init() {
//        request()
//    }
    //Для главного экрана
    func request() {
        let url = URL(string: "http://5.181.255.253/publications/fetch")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode([JSData].self, from: data)
                
                DispatchQueue.main.async {
                    self.dataBase = decodedData
                    
                    // Сохранение в UserDefaults также в основной очереди
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(decodedData), forKey: "cachedData")
                    debugPrint("nqcnwinvwjrbv")
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func takeProfile(id: String, completion: @escaping (ProfileData?) -> Void) {
        var request = URLRequest(url: URL(string: "http://5.181.255.253/user/get?id=\(id)")!)
        // change token
        let tokenForCheck = "bearer \(UserDefaults.standard.string(forKey: "jsonwebtoken")!)"
        debugPrint("from takeProfile    \(tokenForCheck)")
        
        request.addValue(tokenForCheck, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let profileData = try JSONDecoder().decode(ProfileData.self, from: data)
                completion(profileData)
            } catch {
                print("Decoding error: \(error)")
                print(id)
                completion(nil)
            }
        }
        task.resume()
    }
    
    func takeFullCardData(id: String, completion: @escaping (FullCardData?) -> Void) {
        var request = URLRequest(url: URL(string: "http://5.181.255.253/publications/id/\(id)")!)
        
        // change token
        let tokenForCheck = "bearer \(UserDefaults.standard.string(forKey: "jsonwebtoken")!)"
        debugPrint("from takeProfile    \(tokenForCheck)")
        
        request.addValue(tokenForCheck, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let fullCardData = try JSONDecoder().decode(FullCardData.self, from: data)
                completion(fullCardData)
            } catch {
                print("Decoding error: \(error)")
                print(id)
                completion(nil)
            }
        }
        task.resume()
    }
    
    func takeMyPublicationData(){
        var request = URLRequest(url: URL(string: "http://5.181.255.253/my-publications")!)
        
        // change token
        let tokenForCheck = "bearer \(UserDefaults.standard.string(forKey: "jsonwebtoken")!)"
        debugPrint("from takeProfile\(tokenForCheck)")
        
        request.addValue(tokenForCheck, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let myPublicationsData = try JSONDecoder().decode([MyPublicationsData].self, from: data)
                
                DispatchQueue.main.async {
                    self.dataBaseForMyPubs = myPublicationsData
                  debugPrint("dododododo")
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
    
    func takeDataForProfile(completion: @escaping (ProfileData?) -> Void) {
        let userId = "\(UserDefaults.standard.string(forKey: "jswebuserid")!)"
        var request = URLRequest(url: URL(string: "http://5.181.255.253/user/get?id=\(userId)")!)
        // change token
        let tokenForCheck = "bearer \(UserDefaults.standard.string(forKey: "jsonwebtoken")!)"
        debugPrint("from takeProfile    \(tokenForCheck)")
        
        request.addValue(tokenForCheck, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let profileData = try JSONDecoder().decode(ProfileData.self, from: data)
                completion(profileData)
            } catch {
                print("Decoding error: \(error)")
                print(userId)
                completion(nil)
            }
        }
        task.resume()
    }
    
    //Редактирование профиля
    func editProfile(editProfileRequest: EditProfileRequest, completion: @escaping (Bool?, Error?) -> Void) {
        let apiUrl = URL(string: "http://5.181.255.253/profile/edit")!
        
        let tokenForCheck = "bearer \(UserDefaults.standard.string(forKey: "jsonwebtoken")!)"
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tokenForCheck, forHTTPHeaderField: "Authorization")
    
        do {
            let jsonData = try JSONEncoder().encode(editProfileRequest)
            request.httpBody = jsonData
        } catch {
            completion(nil, error)
            return
        }
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
        
            do {
                let response = try JSONDecoder().decode(Bool.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, error)
            }
        }
    
        task.resume()
    }
    
    //for favorite publications
    
    func checkPubFavoriteStatus(pubID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string: "http://5.181.255.253/favorites/publication/\(pubID)/check")!
        var request = URLRequest(url: url)
        
        let tokenForCheck = "bearer \(UserDefaults.standard.string(forKey: "jsonwebtoken")!)"
        request.httpMethod = "GET"
        request.setValue(tokenForCheck, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "YourApiClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                // Парсим JSON-ответ, чтобы получить результат
                let result = try JSONDecoder().decode(Bool.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func addPubToFavorite(changePubFavoriteStatusRequest: ChangePubFavoriteStatusRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string: "http://5.181.255.253/favorites/publication/add")!
        var request = URLRequest(url: url)
        
        let tokenForCheck = "bearer \(UserDefaults.standard.string(forKey: "jsonwebtoken")!)"
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(tokenForCheck, forHTTPHeaderField: "Authorization")
        
        do {
            let requestData = try JSONEncoder().encode(changePubFavoriteStatusRequest)
            request.httpBody = requestData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "YourApiClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                // Парсим JSON-ответ, чтобы получить результат
                let result = try JSONDecoder().decode(Bool.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func removePubFromFavorite(changePubFavoriteStatusRequest: ChangePubFavoriteStatusRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let url = URL(string: "http://5.181.255.253/favorites/publication/remove-single")!
        var request = URLRequest(url: url)
        
        let tokenForCheck = "bearer \(UserDefaults.standard.string(forKey: "jsonwebtoken")!)"
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(tokenForCheck, forHTTPHeaderField: "Authorization")
        
        do {
            let requestData = try JSONEncoder().encode(changePubFavoriteStatusRequest)
            request.httpBody = requestData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "YourApiClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                // Парсим JSON-ответ, чтобы получить результат
                let result = try JSONDecoder().decode(Bool.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
