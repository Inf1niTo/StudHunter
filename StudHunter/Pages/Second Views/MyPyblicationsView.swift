//
//  MyPyblicationsView.swift
//  StudHunter
//
//  Created by Антон Плотников on 24.08.2023.
//

import SwiftUI

struct MyPyblicationsView: View {
    @ObservedObject var data: Requesting
    
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var colorScheme
    
    let columns:[GridItem] = [GridItem(.fixed(Settings.shared.productCardSize), spacing: 28, alignment: nil)]

    var body: some View {
        ZStack{
            //NavigationView {
                VStack(spacing: 0){
                    HStack{
                        backButtom
                            .padding(.trailing,20)
                        
                        Text("Мои объявления")
                            .font(.system(size: 25))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 34, alignment: .top)
                    .padding(.horizontal,20)
                    .padding(.top,56)
                    .padding(.bottom,26)
                    .background(Color.colors.white)
                    .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                    ScrollView{
                        LazyVGrid(columns: columns) {
                            ForEach(data.dataBaseForMyPubs ?? [MyPublicationsData](), id: \.id){ data in
                                ZStack{
                                        HStack(spacing: 0){
                                            AsyncImage(url: URL(string: data.imageUrl)){image in
                                                image
                                                    .resizable()
                                                    .frame(maxWidth:140, maxHeight: 140,alignment: .top)
                                                    .overlay {
                                                        Button {
                                                            //
                                                        } label: {
                                                            VStack{
                                                                HStack{
                                                                    Spacer()
                                                                    Rectangle()
                                                                        .frame(width: 20, height: 20)
                                                                        .foregroundColor(Color.colors.white.opacity(0.8))
                                                                        .cornerRadius(3)
                                                                        .overlay {
                                                                            Image(systemName: "pencil")
                                                                        }
                                                                        .foregroundColor(Color.colors.black.opacity(0.8))
                                                                }
                                                                .padding(.trailing, 10)
                                                                
                                                                Spacer()
                                                            }
                                                            .padding(.top, 10)
                                                            
                                                        }
                                                    }
                                            }placeholder: {
                                                Image(systemName: "photo")
                                                    .frame(width: 140, height: 140, alignment: .center)
                                            }
                                            VStack{
                                                Text("\(data.price ?? 0) \(data.priceType)")
                                                    .foregroundColor(Color.colors.black)
                                                    .padding(.top, 1)
                                                    .padding(.leading, 8)
                                                    .font(Font.custom("Gilroy-Semibold", size: 19))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.top, 12)
                                                
                                                Spacer()
                                                
                                                Text(data.title)
                                                    .multilineTextAlignment(.leading)
                                                    .lineLimit(2, reservesSpace: false)
                                                    .foregroundColor(Color.colors.black)
                                                    .padding(.leading,8)
                                                    .font(Font.custom("Gilroy-Medium", size: 18))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                                
                                                Spacer()
                                                
                                                Text(data.description)
                                                    .multilineTextAlignment(.leading)
                                                    .foregroundColor(Color.colors.black)
                                                    .padding(.leading,8)
                                                    .font(Font.custom("Gilroy-Regular", size: 19))
                                                    .lineLimit(2, reservesSpace: false)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                                Spacer()
                                                
                                               
                                                HStack{
                                                    HStack{
                                                        Image(systemName: "eye")
                                                        Text(String(data.views))
                                                    }
                                                    

                                                    HStack{
                                                        Image(systemName: "heart.fill")
                                                        Text(String(data.favorites))
                                                    }
                                                    Spacer()
                                                }
                                                .foregroundColor(Color.colors.black)
                                                .font(Font.custom("Gilroy-Regular", size: 14))
                                                .padding(.leading,8)
                                                Spacer()
                                            }
                                        }
                                        .frame(width: 370, height: 140)
                                        .background(Color.colors.white)
                                        .cornerRadius(16)
                                        .shadow(color: Color.init(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.08), radius: 6, x: 0, y: 4)
                                }
                                .padding(.top, 8)
                            }
                        }
                    }.onAppear(){
                        data.takeMyPublicationData()
                    }
                }
                Spacer()
           // }
        }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
            .background(Color.colors.background.ignoresSafeArea())
        }

    }

struct MyPyblicationsView_Previews: PreviewProvider {
    static var previews: some View {
        MyPyblicationsView(data: Requesting())
    }
}
extension MyPyblicationsView{
    
    var backButtom : some View {
        Button {
            mode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(Color.colors.black)
        }
    }
}
