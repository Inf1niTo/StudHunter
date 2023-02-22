//
//  BestView.swift
//  StudHunter
//
//  Created by Антон Сетямин on 16.02.2023.
//

import SwiftUI

struct BestView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Избранное")
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: 34, alignment: .top)
            .padding(.horizontal,20)
            .padding(.top,56)
            .padding(.bottom,26)
            .background(Color.colors.white)
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            Spacer()
            
            Text("Избранное View")
            
            Spacer()
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
    }
}
struct BestView_Previews: PreviewProvider {
    static var previews: some View {
        BestView()
    }
}
