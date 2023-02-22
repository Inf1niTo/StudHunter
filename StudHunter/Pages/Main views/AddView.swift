//
//  AddView.swift
//  StudHunter
//
//  Created by Антон Сетямин on 16.02.2023.
//

import SwiftUI

struct AddView: View {
    var arr = (1...100)
    var body: some View {
        VStack {
            HStack{
                Text("Создать объявление")
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: 34)
            .padding(.horizontal,20)
            .padding(.top,56)
            .padding(.bottom,26)
            .background(Color.colors.white)
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            
            Spacer()
            
            Button(action: {
            }) {
                NavigationLink(destination: CreateCardPage()) {
                    HStack{
                        Text("Создать")
                            .font(.system(size: 24))
                            .frame(width: 168, height: 56, alignment: .center)
                            .background(Color.colors.primary)
                            .foregroundColor(Color.white)
                    }
                }
                .cornerRadius(12)
            }

            Spacer()
            
        
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
