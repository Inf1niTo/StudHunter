//
//  CreateCardPage.swift
//  StudHunter
//
//  Created by Антон Плотников on 07.06.2023.
//

import SwiftUI
import PhotosUI
import CoreTransferable

struct CreateCardPage: View {
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var colorScheme
    
    
    @State var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State var poshla = publicationService()
    
    @State private var selectedCategory = ""
    @State private var selectedPriceType = ""
    @State private var selectedLocation = ""
    
    @StateObject private var dataFetcher = DataFetcher()
    
    @State var priceText = ""
    @State var titleText = ""
    @State var descriptionText = ""
    
    @State var images: [UIImage] = []
    @State var selectedItems: [PhotosPickerItem] = []
    @State private var name: String = ""
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                HStack{
                    backButtom
                    .padding(.trailing,20)
                    
                    Text("Создание объявления")
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
                    Group{
                        VStack{
                            Text("Добавить фото")
                                .font(Font.custom("Gilroy-Regular", size: 22))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 2)
                            
                            Text("Не более 3 фотографий")
                                .font(Font.custom("Gilroy-Regular", size: 14))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                        }
                        .padding(20)
                        
                        if images != []{
                            ScrollView{
                                HStack {
                                    ForEach(images.reversed(), id: \.cgImage) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .cornerRadius(16)
                                    }
                                    Spacer()
                                }
                                .padding(.leading, 14)
                            }
                        }else{
                            PhotosPicker(selection: $selectedItems,
                                         matching: .images) {
                                Rectangle()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.gray)
                                    .opacity(0.5)
                                    .cornerRadius(16)
                                    .overlay {
                                            Image(systemName: "photo")
                                                .foregroundColor(.gray)
                                    }
                                    .padding(.leading, 14)
                                Spacer()
                            }
                                         .onChange(of: selectedItems) { selectedItems in
                                             images = []
                                             for item in selectedItems {
                                                 item.loadTransferable(type: Data.self) { result in
                                                     switch result {
                                                     case .success(let imageData):
                                                         if let imageData {
                                                             self.images.append(UIImage(data: imageData)!)
                                                         } else {
                                                             print("No supported content type found.")
                                                         }
                                                     case .failure(let error):
                                                         print(error)
                                                     }
                                                 }
                                             }
                                         }
                        }

                        HStack{
                            Text("Добавить название")
                                .font(Font.custom("Gilroy-Regular", size: 20))
                                .padding(.leading, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
   
                        }
                        .padding(.top, 16)
                        .padding(.trailing, 20)
                        
                        TextField("Название", text: $titleText)
                            
                            .font(Font.custom("Gilroy-Regular", size: 20))
                            .padding(17)
                            .background(colorScheme == .light ? Color.white : Color.black)
                            .cornerRadius(12)
                            .frame(width: 395, alignment: .center)

                        
                        Text("Добавьте описание")
                            .font(Font.custom("Gilroy-Regular", size:20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .padding(.top, 10)
                        
                        Spacer()
                        
                        VStack {
                            TextEditor(text: $descriptionText)
                                .font(Font.custom("Gilroy-Regular", size: 20))
                                .multilineTextAlignment(.leading)
                                .cornerRadius(12)
                                .frame(minHeight: 58)
                                .lineSpacing(6)
                                
                        }
                        .frame(width: 395, alignment: .center)
                        .overlay(){
                            
                            if descriptionText == ""{
                                Text("Описание")
                                    .font(Font.custom("Gilroy-Regular", size: 20))
                                    .foregroundColor(Color.gray.opacity(0.5))
                                    .frame(width: 346, alignment: .leading)
                            }else{
                                Text("")
                            }
                        }
                    }
                    
                    Text("Укажите район")
                        .font(Font.custom("Gilroy-Regular", size: 20))
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Menu {
                        Picker("Select Location", selection: $selectedLocation) {
                            ForEach(dataFetcher.selectedLocation, id: \.self) { value in
                                Text(value).tag(value)
                            }
        
                        }
                        .padding()
                        .onChange(of: selectedLocation) { _ in
                            Task {
                            }
                        }
                               }label:{
                                locationLabel
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                        .onAppear {
                            dataFetcher.takeLocation()
                        }
                    
                    Text("Укажите цену")
                        .font(Font.custom("Gilroy-Regular", size: 20))
                        .padding(.leading, 20)
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)


                    TextField("Цена", text: $priceText)

                        .font(Font.custom("Gilroy-Regular", size: 20))
                        .padding(17)
                        .background(colorScheme == .light ? Color.white : Color.black)
                        .cornerRadius(12)
                        .frame(width: 395, alignment: .center)
                    
                    Menu {
                        Picker("Select PriceType", selection: $selectedPriceType) {
                            ForEach(dataFetcher.selectedPriceType, id: \.self) { value in
                                Text(value).tag(value)
                            }
        
                        }
                        .padding()
                        .onChange(of: selectedPriceType) { _ in
                            Task {
                            }
                        }
                            }label: {
                                priceTypeLabel
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                        .onAppear {
                            dataFetcher.takePriceType()
                        }
                    
                    Text("Укажите категорию")
                        .font(Font.custom("Gilroy-Regular", size: 20))
                        .padding(.leading, 20)
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Menu {
                        Picker("Select Category", selection: $selectedCategory) {
                            ForEach(dataFetcher.selectedCategories, id: \.self) { value in
                                Text(value).tag(value)
                            }
        
                        }
                        .padding()
                        .onChange(of: selectedCategory) { _ in
                            Task {
                            }
                        }
                            }label: {
                                categoriesLabel
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                        .onAppear {
                            dataFetcher.takeCategoies()
                        }
                    
                    VStack(){
                        Button {
                            poshla.uploadData(images: images, title: titleText, description: descriptionText, priceType: selectedPriceType, location: selectedLocation, category: selectedCategory, price: priceText)
                            mode.wrappedValue.dismiss()
                            
                        } label: {
                            Rectangle()
                                .frame(width: 240, height: 50)
                                .foregroundColor(Color.colors.primary)
                                .cornerRadius(16)
                                .overlay {
                                    Text("Создать объявление")
                                        .font(Font.custom("Gilroy-Regular", size: 18))
                                        .foregroundColor(Color.white)
                                }
                        }

                        Rectangle()
                            .frame(width: 240, height: 80)
                            .foregroundColor(Color.colors.background)
                            .cornerRadius(16)
                            .overlay {
                                Button {
                                    selectedItems = []
                                    images = []
                                    
                                } label: {
                                    Text("\(Image(systemName: "trash"))  Удалить объявление")
                                        .font(Font.custom("Gilroy-Regular", size: 18))
                                        .foregroundColor(Color.colors.red)
                                }
                            }
                    }
                    .padding(.top, 20)
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
    }
}
extension CreateCardPage{
    
    var backButtom : some View {
        Button {
            mode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(Color.colors.black)
        }
    }
    
    var imagePicker : some View {
        Button {
            mode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(Color.colors.black)
        }
    }
    var categoriesLabel: some View {
        HStack {
            Text(selectedCategory)
                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                .padding(.leading, 20)
            Spacer()
            Text("⌵")
                .offset(y: -4)
                .offset(x: -16)
        }
        .font(Font.custom("Gilroy-Regular", size: 20))
        .frame(width: 396, height: 54)
        .cornerRadius(16)
        .background(colorScheme == .light ? Color.white : Color.black)
        }
    
    var locationLabel: some View {
        HStack {
            Text(selectedLocation)
                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                .padding(.leading, 20)
            Spacer()
            Text("⌵")
                .offset(y: -4)
                .offset(x: -16)
        }
        
        //.padding(.bottom,20)
        .font(Font.custom("Gilroy-Regular", size: 20))
        .frame(width: 396, height: 54)
        .cornerRadius(16)
        .background(colorScheme == .light ? Color.white : Color.black)
        }
    
    var priceTypeLabel: some View {
        HStack {
            Text(selectedPriceType)
                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                .padding(.leading, 20)
            Spacer()
            Text("⌵")
                .offset(y: -4)
                .offset(x: -16)
        }
        .font(Font.custom("Gilroy-Regular", size: 20))
        .frame(width: 396, height: 54)
        .cornerRadius(16)
        .background(colorScheme == .light ? Color.white : Color.black)
        }
}

struct CreateCardPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateCardPage()
    }
}
