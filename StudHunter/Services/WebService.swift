//
//  WebService.swift
//  StudHunter
//
//  Created by Антон Плотников on 08.06.2023.
//

import Foundation

enum AuthenticationError: Error{
  case invalidCredentials
  case custom(errorMessage: String)
}

struct LoginRequestBody: Codable{
    let username: String
    let password: String
    let email: String
    let name: String
    let surname: String
    let university: String
}

enum NetworkError: Error{
    case invalidURL(errorMessage: String)
    case noData(errorMessage: String)
    case decodingError(errorMessage: String)
}

struct SignInRequestBody: Codable{
    let username: String
    let password: String
}

struct LoginResponse: Codable{
    let token: String?
    let message: String?
    let success: String?
}

struct text: Codable{
    let request: String?
}

class Webservice {
    @Published var defaults = UserDefaults.standard

    
    func signup(username: String, password: String, email:String, name:String, surname:String, university: String, completion: @escaping(Result<String, AuthenticationError>) -> Void){
        
        guard let url = URL(string: "http://5.181.255.253/signup") else{
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(username: username, password: password, email: email, name: name, surname: surname, university: university)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }

            guard let loginResponse = try?  JSONDecoder().decode(LoginResponse.self, from: data) else{
                completion(.failure(.invalidCredentials))
                return
            }

            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            debugPrint("polycheniy token from login       \(token)")
            completion(.success(token))
            
        }.resume()
        
    }
    

    
    func login(username: String, password: String, completion: @escaping(Result<String, AuthenticationError>) -> Void){
        
        guard let url = URL(string: "http://5.181.255.253/signin") else{
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = SignInRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }

            guard let loginResponse = try?  JSONDecoder().decode(LoginResponse.self, from: data) else{
                completion(.failure(.invalidCredentials))
                return
            }
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            debugPrint("polycheniy token from login     \(token)")
            completion(.success(token))
            
        }.resume()
        
    }
    
    func takeUserId(completion: @escaping(Result<String, NetworkError>) -> Void){
        
        let token = "bearer \(UserDefaults.standard.string(forKey: "jsonwebtoken")!)"
        
        guard let url = URL(string: "http://5.181.255.253/userid") else{
            completion(.failure(.invalidURL(errorMessage: "hrenoviy url")))
            return
        }
        var request = URLRequest(url: url)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let userId = data, error == nil else{
                completion(.failure(.noData(errorMessage: "tyt data ne beret'sya")))
                return
            }
            let newUserId = String(data: userId, encoding: .utf8)!

            self.defaults.setValue(newUserId, forKey: "jswebuserid")
            
            debugPrint(newUserId.description)
            completion(.success(data.debugDescription))
            
        }.resume()
        
    }
    
}
