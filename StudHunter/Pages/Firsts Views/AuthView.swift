//
//  AuthView.swift
//  StudHunter
//
//  Created by Антон Плотников on 08.06.2023.
//

import SwiftUI

struct AuthView: View {
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var colorScheme
    
    @State var numberText = ""
    @State var mailText = ""
    @State var passText = ""
    @StateObject private var signVM = LoginViewModel()
    
    
    var body: some View {
        ZStack{
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
                    
                    TextField("Логин", text: $signVM.username)
                        .font(Font.custom("Gilroy-Regular", size: 20))
                        .padding(17)
                        .padding(.horizontal, 5)
                        .background(colorScheme == .light ? Color.white : Color.black)
                        .cornerRadius(12)
                        .padding(.horizontal, 10)
                        .padding(.top, 18)
                        .textInputAutocapitalization(.never)
                    
                    TextField("Введите пароль", text: $signVM.password)
                        .font(Font.custom("Gilroy-Regular", size: 20))
                        .padding(17)
                        .padding(.horizontal, 5)
                        .background(colorScheme == .light ? Color.white : Color.black)
                        .cornerRadius(12)
                        .padding(.horizontal, 10)
                        .padding(.top, 14)
                        .textInputAutocapitalization(.never)
                    
                    TextField("Введите почту", text: $signVM.email)
                        .font(Font.custom("Gilroy-Regular", size: 20))
                        .padding(17)
                        .padding(.horizontal, 5)
                        .background(colorScheme == .light ? Color.white : Color.black)
                        .cornerRadius(12)
                        .padding(.horizontal, 10)
                        .padding(.top, 14)
                        .textInputAutocapitalization(.never) 
                }
                
                Button(action: {
                   
                }) {
                    NavigationLink(destination: AuthSecondView()) {
                        Rectangle()
                            .frame(width: 374, height: 54)
                            .foregroundColor(Color.colors.background)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(LinearGradient(colors: [Color.colors.firstForGr, Color.colors.secondForGr, Color.colors.thirdForGr, Color.colors.fourForGr],
                                        startPoint: .leading,
                                        endPoint: .trailing), lineWidth: 1)
                            )
                            .overlay {
                                LinearGradient(
                                    colors: [Color.colors.firstForGr, Color.colors.secondForGr, Color.colors.thirdForGr, Color.colors.fourForGr],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                
                                .frame(width: 130)
                                .mask {
                                    Text("Продолжить")
                                        .font(Font.custom("Gilroy-Regular", size: 22))
                                }
                            }
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
