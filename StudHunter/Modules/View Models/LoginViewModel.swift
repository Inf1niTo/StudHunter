//
//  LoginViewModel.swift
//  StudHunter
//
//  Created by Антон Плотников on 08.06.2023.
//

import Foundation

class LoginViewModel: ObservableObject{
     
    var username: String = ""
    var password: String = ""
    var email: String = ""
    var name: String = ""
    var surname: String = ""
    var university: String = ""
    
    @Published var isAuthenticated: Bool = false
    @Published var defaults = UserDefaults.standard
    


    
    func signup(){
        Webservice().signup(username: username, password: password, email: email, name: name, surname: surname, university: university) { result in
            switch result{
            case .success(let token):
                self.defaults.set(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    debugPrint("________\(token)")
                    self.check()

                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func login(){
        Webservice().login(username: username, password: password) { result in
            switch result{
            case .success(let token):
                self.defaults.set(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    debugPrint(token)
                    self.check()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout(){
        //let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
    
    func check(){
        
        Webservice().takeUserId{ (result) in
            switch result{
                case .success(let acc):
                    debugPrint("check access  \(acc)")
                
                case .failure(let error):
                    debugPrint("its error check\(error.localizedDescription)")
            }
        }
    }
}
