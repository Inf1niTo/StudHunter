//
//  SignInView.swift
//  StudHunter
//
//  Created by Антон Плотников on 08.06.2023.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var colorScheme
    
    @State var signInMailText = ""
    @State var signInPassText = ""
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                    NavigationLink(destination: StudHunterView().navigationBarBackButtonHidden(true), isActive: $loginVM.isAuthenticated) {
                                        EmptyView()
                                    }
                VStack(spacing: 0){
                    
                    HStack{
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.colors.black)
                        }
                        
                        Text("Вход")
                            .font(.system(size: 25))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 34)
                    .padding(.horizontal,20)
                    .padding(.top,56)
                    .padding(.bottom,26)
                    .background(Color.colors.white)
                    .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                    
                    ScrollView{
                        
                        
                        Text("Для входа в приложение введите вашу почту и пароль")
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 14)
                            .padding(.horizontal, 20)
                        
                        TextField("Введите логин", text: $loginVM.username)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .padding(17)
                            .padding(.horizontal, 5)
                            .background(colorScheme == .light ? Color.white : Color.black)
                            .cornerRadius(12)
                            .padding(.horizontal, 10)
                            .padding(.top, 18)
                            .textInputAutocapitalization(.never)
                        
                        SecureField("Введите пароль", text: $loginVM.password)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .padding(17)
                            .padding(.horizontal, 5)
                            .background(colorScheme == .light ? Color.white : Color.black)
                            .cornerRadius(12)
                            .padding(.horizontal, 10)
                            .padding(.top, 14)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Button {
                        loginVM.login()
                    } label: {
                            Rectangle()
                                .opacity(0)
                                .frame(width: 374, height: 54)
                                .background(
                                    LinearGradient(
                                        colors: [Color.colors.secForTopGr, Color.colors.firstForTopGr],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                                .cornerRadius(16)
                                .blur(radius: 4)
                                .overlay {
                                    Rectangle()
                                        .opacity(0)
                                        .frame(width: 374, height: 54)
                                        .background(
                                            LinearGradient(
                                                colors: [Color.colors.secForTopGr, Color.colors.firstForTopGr],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            ))
                                        .cornerRadius(16)
                                        .overlay {
                                            Text("Войти")
                                                .font(Font.custom("Gilroy-Regular", size: 20))
                                                .foregroundColor(Color.colors.white)
                                        }
                                }
                    }
                    .padding(.bottom, 50)
                }
                .background(Color.colors.background.ignoresSafeArea())
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
