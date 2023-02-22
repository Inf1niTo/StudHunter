//
//  WelcomeView.swift
//  StudHunter
//
//  Created by Антон Плотников on 08.06.2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack{
            VStack(){
                Spacer()
                Text("Добро пожаловать!")
                    .font(Font.custom("Gilroy-Regular", size: 22))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20)
                
                Text("Для продолжения зарегистрируйтесь, что бы пользоваться всеми функциями приложения")
                    .font(Font.custom("Gilroy-Regular", size: 20))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button(action: {
                }) {
                    NavigationLink(destination: AuthSecondView()) {
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
                                        Text("Зарегистрироваться")
                                            .font(Font.custom("Gilroy-Regular", size: 20))
                                            .foregroundColor(Color.colors.white)
                                    }
                            }
                    }
                    .padding(.bottom, 0)
                }
 
                Button(action: {
                }) {
                    NavigationLink(destination: SignInView()) {
                        Rectangle()
                            .frame(width: 374, height: 54)
                            .foregroundColor(Color.colors.background)
                            .cornerRadius(16)
                            .overlay {
                                LinearGradient(
                                    colors: [Color.colors.firstForGr, Color.colors.secondForGr, Color.colors.thirdForGr, Color.colors.fourForGr],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )

                                .frame(width: 70)
                                    .mask {
                                        Text("Войти")
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

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
