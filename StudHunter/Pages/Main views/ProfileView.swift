//
//  ProfileView.swift
//  StudHunter
//
//  Created by Антон Сетямин on 16.02.2023.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var logoutVM = LoginViewModel()
    @State private var profileData: ProfileData?
    
    @State private var test: String = ""
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var nickname: String = ""
    @State private var raiting: String = ""
    @State private var id: String = ""
    @State private var email: String = ""
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
        
                Text("Профиль")
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                        debugPrint("___\(id)")
                } label: {
                    Image(systemName: "bell")
                        .font(.system(size: 22))
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        .padding(.trailing, 24)
                }

                
                Button {
                    //
                } label:{
                    NavigationLink {
                        EditProfileView()
                    } label: {
                        Image(systemName: "pencil")
                            .font(.system(size: 22))
                            .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                            .padding(.trailing, 10)
                    }
                }

            }
            .frame(maxWidth: .infinity, maxHeight: 34, alignment: .top)
            .padding(.horizontal,20)
            .padding(.top,56)
            .padding(.bottom,26)
            .background(Color.colors.white)
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            
            
            ScrollView{
                HStack{
                    if id != ""{
                        Button {
                        //change pic
                        } label: {
                            AsyncImage(url: URL(string:"https://storage.yandexcloud.net/stud-hunter-bucket/users/avatars/\(id)")){image in
                                image.image?
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width:100 ,height: 100)
                                    .cornerRadius(90)
                                    .padding(.leading, 30)
                            }
                        }

                    }else{
                            Image(systemName: "person.circle")
                                .font(.system(size: 90))
                                .padding(.leading, 20)
                                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        }
                    
                    VStack(spacing: 10){
                        Text("\(name) \(surname)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Gilroy-Regular", size: 20))


                        Text(verbatim: "\(email)")
                            
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Gilroy-Regular", size: 18))
                            .foregroundColor(colorScheme == .light ? Color.black : Color.white)

                    }
                    .padding(.leading, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 140)
                .padding(.top, 0)
                
                VStack(spacing: 20){
                    Button {
                        //
                    } label:{
                    NavigationLink {
                        MyPyblicationsView(data: Requesting())
                    } label: {
                        Text("Мои объявления")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 24)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .frame(width: 380, height: 56, alignment: .center)
                            .background(Color.colors.white)
                            .foregroundColor(Color.colors.black)
                            .cornerRadius(12)
                    }

                }
                    
                    Button {
                        //
                    } label: {
                        Text("История услуг")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 24)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .frame(width: 380, height: 56, alignment: .center)
                            .background(Color.colors.white)
                            .foregroundColor(Color.colors.black)
                            .cornerRadius(12)
                        
                    }
                    
                    Button {
                        //
                    } label: {
                        Text("Справочная информация")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 24)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .frame(width: 380, height: 56, alignment: .center)
                            .background(Color.colors.white)
                            .foregroundColor(Color.colors.black)
                            .cornerRadius(12)
                        
                    }
                    
                    Button {
                        //
                    } label: {
                        Text("Забыли пароль")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 24)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .frame(width: 380, height: 56, alignment: .center)
                            .background(Color.colors.white)
                            .foregroundColor(Color.colors.black)
                            .cornerRadius(12)
                        
                    }
                    
                    Button {
                        //
                    } label: {
                        Text("О нас")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 24)
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .frame(width: 380, height: 56, alignment: .center)
                            .background(Color.colors.white)
                            .foregroundColor(Color.colors.black)
                            .cornerRadius(12)
                        
                    }
                    
                    Button {
                        
                    } label: {
                        NavigationLink {
                            AboutAppPage()
                        } label: {
                            Text("О приложении")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 24)
                                .font(Font.custom("Gilroy-Regular", size: 20))
                                .frame(width: 380, height: 56, alignment: .center)
                                .background(Color.colors.white)
                                .foregroundColor(Color.colors.black)
                                .cornerRadius(12)
                        }

                    }
                    Spacer()
                    
                    Button(action: {
                        logoutVM.logout()
                    }) {
                        NavigationLink(destination: WelcomeView()) {
                            Text("\(Image(systemName: "arrow.left.to.line"))  Выйти из аккаунта")
                                .font(Font.custom("Gilroy-Regular", size: 20))
                                .foregroundColor(Color.colors.eertiary)                        }
                        .padding(.bottom, 0)
                    }

                }

                
            }
        }
        .onAppear(){
            Requesting().takeDataForProfile() { loadedProfileData in
                if let loadedProfileData = loadedProfileData {
                    DispatchQueue.main.async {
                        profileData = loadedProfileData
                        name = loadedProfileData.name
                        surname = loadedProfileData.surname
                        email = loadedProfileData.email
                        let num = loadedProfileData.rating
                        raiting = String(format: "%.1f", num)
                        id = loadedProfileData.id
                    }
                        } else {
            // Обработка ошибки, если не удалось загрузить профиль
                            }
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
