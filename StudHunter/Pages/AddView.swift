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
            List{
                Text("1dd")
                Text("2dd")
                Text("3dd")
                Text("4dd")
                Text("d23d")
                Text("dd")
                Text("34dd")
                Text("dd")
                Text("6dd")
                Text("dd")
                
                
            }
            List{
                Text("1dd")
                Text("2dd")
                Text("3dd")
                Text("4dd")
                Text("d23d")
                Text("dd")
                Text("34dd")
                Text("dd")
                Text("6dd")
                Text("dd")
                
                
            }
            List{
                Text("1dd")
                Text("2dd")
                Text("3dd")
                Text("4dd")
                Text("d23d")
                Text("dd")
                Text("34dd")
                Text("dd")
                Text("6dd")
                Text("dd")
                
                
            }
//            Text("Add View")
//                .font(.largeTitle)
//                .foregroundColor(Color.colors.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
