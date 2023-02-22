//
//  ProfileView.swift
//  StudHunter
//
//  Created by Антон Сетямин on 16.02.2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Text("Profile View")
                .font(.largeTitle)
                .foregroundColor(Color.colors.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
