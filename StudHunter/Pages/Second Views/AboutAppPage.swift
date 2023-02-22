//
//  AboutAppPage.swift
//  StudHunter
//
//  Created by Антон Плотников on 07.06.2023.
//

import SwiftUI

struct AboutAppPage: View {
    @Environment(\.presentationMode) var mode

    var body: some View {
        VStack(spacing: 0){
            HStack{
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.colors.black)
                }
                
                Text("О приложении")
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
                
                Text("StudHunter - это сервис объявлений о различных товарах и услугах, предназначенный для студентов.")
                    .lineLimit(nil)
                    .font(Font.custom("Gilroy-Regular", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 12)
                    .padding(.horizontal, 20)
                    
                
                Text("Мы появились совсем недавно, но мы растем, помогая учащимся вузов совершать выгодные сделки, а также развивать свои предпринимательские способности.")
                    .lineLimit(nil)
                    .font(Font.custom("Gilroy-Regular", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 12)
                    .padding(.horizontal, 20)
                
                Text("Наша цель - сделать жизнь студентов проще.")
                    .lineLimit(nil)
                    .font(Font.custom("Gilroy-Regular", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 12)
                    .padding(.horizontal, 20)
                
                Text("Через приложение мы помогаем людям получить то, что им нужно быстрым и доступным образом.")
                    .lineLimit(nil)
                    .font(Font.custom("Gilroy-Regular", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 12)
                    .padding(.horizontal, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
    }
}

struct AboutAppPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppPage()
    }
}
