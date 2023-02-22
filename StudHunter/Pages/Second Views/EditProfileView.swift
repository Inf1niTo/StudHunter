//
//  EditProfileView.swift
//  StudHunter
//
//  Created by Антон Плотников on 06.09.2023.
//

import SwiftUI

struct EditProfileView: View {
    @State var request = Requesting()
    
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var colorScheme
    
    @State var nameText = ""
    @State var surenameText = ""
    @State var universityText = ""
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.colors.black)
                }
                
                Text("Редактирование профиля")
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
            .padding(.bottom, 10)
            
            
            VStack{
                
                TextField("Новое Имя", text: $nameText)
                    .font(Font.custom("Gilroy-Regular", size: 20))
                    .padding(17)
                    .background(colorScheme == .light ? Color.white : Color.black)
                    .cornerRadius(12)
                    .frame(width: 395, alignment: .center)
                    .padding(.bottom, 10)
                
                TextField("Новая Фамилия", text: $surenameText)
                    .font(Font.custom("Gilroy-Regular", size: 20))
                    .padding(17)
                    .background(colorScheme == .light ? Color.white : Color.black)
                    .cornerRadius(12)
                    .frame(width: 395, alignment: .center)
                    .padding(.bottom, 10)
                
                TextField("Новый университет", text: $universityText)
                    .font(Font.custom("Gilroy-Regular", size: 20))
                    .padding(17)
                    .background(colorScheme == .light ? Color.white : Color.black)
                    .cornerRadius(12)
                    .frame(width: 395, alignment: .center)
                   
            }
            Spacer()
            
            Button {
                let editProfileRequest = EditProfileRequest(name: nameText, surname: surenameText, university: universityText)
                request.editProfile(editProfileRequest: editProfileRequest) { success, error in
                    if let error = error {
                            print("Error: \(error)")
                        } else if let success = success {
                            if success {
                                print("Profile edited successfully.")
                            } else {
                                print("Profile edit failed.")
                            }
                        }
                    }
                mode.wrappedValue.dismiss()
                
            } label: {
                Rectangle()
                    .frame(width: 240, height: 50)
                    .foregroundColor(Color.colors.primary)
                    .cornerRadius(16)
                    .overlay {
                        Text("Сохранить")
                            .font(Font.custom("Gilroy-Regular", size: 18))
                            .foregroundColor(Color.white)
                    }
                
            }
            .padding(.bottom, 50)

        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
