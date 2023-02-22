//
//  AuthSecondView.swift
//  StudHunter
//
//  Created by Антон Плотников on 08.06.2023.
//

import SwiftUI

struct AuthSecondView: View {
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var colorScheme
    
    @State var nameText = ""
    @State var surnameText = ""
    @StateObject private var signVM = LoginViewModel()
    @State var errorText = ""
    @State var showDetail = false

    
    var body: some View {
        NavigationView{
            ZStack{
                NavigationLink(destination: StudHunterView().navigationBarBackButtonHidden(true), isActive: $signVM.isAuthenticated) {
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
                        
                        Text("Регистрация")
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
                        
                        Text("Укажите данные для регистрации пользователя")
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 14)
                            .padding(.horizontal, 20)
                        
                        
                        TextField("Имя", text: $signVM.name)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .padding(17)
                            .padding(.horizontal, 5)
                            .background(colorScheme == .light ? Color.white : Color.black)
                            .cornerRadius(12)
                            .padding(.horizontal, 10)
                            .padding(.top, 18)
                            .textInputAutocapitalization(.never)
                        
                        TextField("Фамилия", text: $signVM.surname)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .padding(17)
                            .padding(.horizontal, 5)
                            .background(colorScheme == .light ? Color.white : Color.black)
                            .cornerRadius(12)
                            .padding(.horizontal, 10)
                            .padding(.top, 14)
                            .textInputAutocapitalization(.never)
                        
                        TextField("Логин", text: $signVM.username)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .padding(17)
                            .padding(.horizontal, 5)
                            .background(colorScheme == .light ? Color.white : Color.black)
                            .cornerRadius(12)
                            .padding(.horizontal, 10)
                            .padding(.top, 14)
                            .textInputAutocapitalization(.never)
                        
                        SecureField("Пароль", text: $signVM.password)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .padding(17)
                            .padding(.horizontal, 5)
                            .background(colorScheme == .light ? Color.white : Color.black)
                            .cornerRadius(12)
                            .padding(.horizontal, 10)
                            .padding(.top, 14)
                            .textInputAutocapitalization(.never)
                        
                        
                        TextField("Электронная почта", text: $signVM.email)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .padding(17)
                            .padding(.horizontal, 5)
                            .background(colorScheme == .light ? Color.white : Color.black)
                            .cornerRadius(12)
                            .padding(.horizontal, 10)
                            .padding(.top, 14)
                            .textInputAutocapitalization(.never)
                        
                        
                        TextField("Университет", text: $signVM.university)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .padding(17)
                            .padding(.horizontal, 5)
                            .background(colorScheme == .light ? Color.white : Color.black)
                            .cornerRadius(12)
                            .padding(.horizontal, 10)
                            .padding(.top, 14)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Text(errorText)
                        .font(Font.custom("Gilroy-Regular", size: 20))
                        .foregroundColor(Color.colors.red)
                        .padding(.bottom, 44)
                        .multilineTextAlignment(.center)

                    Button {
                        errorText = ""
                        if signVM.username.count < 6{
                            errorText = "Логин должен содержать более шести символов"
                        }else{
                            if signVM.password.count < 6{
                                errorText = "Пароль должен содержать более шести символов"
                            }else{
                                if signVM.email.contains("@"){
                                    signVM.signup()
                                }else{
                                    errorText = "Проверте правильность введеной почты"
                                }
                            }
                        }
                        
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
                                        Text("Регистрация")
                                            .font(Font.custom("Gilroy-Regular", size: 20))
                                            .foregroundColor(Color.colors.white)
                                    }
                            }
                    }
                    .padding(.bottom, 50)
                }
                
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.colors.background.ignoresSafeArea())
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AuthSecondView_Previews: PreviewProvider {
    static var previews: some View {
        AuthSecondView()
    }
}
