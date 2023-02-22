//
//  SwiftUIView.swift
//  StudHunter
//
//  Created by Антон Плотников on 19.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var filtersVM: FiltersViewModel?
    
    
    @State private var showModal = false
    
    var body: some View {
        VStack{
            //Text(filtersVM.categories)
            Text("a")
            Button("Show Sheet") {
                showModal.toggle()
            }
            .sheet(isPresented: $showModal) {
                SheetView()
            }
        }
    }
}

struct SheetView: View {
    @State private var filtersVM: FiltersViewModel?
    @StateObject private var dataFetcher = DataFetcher()
    @State var pubService = publicationService()
    
    @State var minPrice: Int? = 0
    @State var maxPrice: Int? = 0
    @State var priceTypes: [String] = []
    @State var districts: [String] = []
    @State var categories: [String] = []
    @State var minUserRating: Int? = 0
    
    @State var minPriceText: String = ""
    @State var maxPriceText: String = ""
    @State var priceTypesText: String = ""
    @State var districtsText: String = ""
    @State var categoriesText: String = ""
    @State var minUserRatingText: String = ""
    
    @State var filterIsActive = false
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var isValue:[String] = []
    
   
    @State var raiting = ["1.0", "2.0", "3.0", "4.0", "5.0"]
    
    let columns = [
        GridItem(.flexible(minimum: 34, maximum: 40), alignment: .leading),
        GridItem(.flexible(minimum: 34, maximum: 40), alignment: .leading),
        GridItem(.flexible(minimum: 34, maximum: 40), alignment: .leading),
        GridItem(.flexible(minimum: 34, maximum: 130), alignment: .leading)
        //GridItem(.flexible(minimum: 20, maximum: 20), alignment: .leading)
    ]
    
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                
                Text("Категория")
                    .font(Font.custom("Gilroy-Regular", size: 28))
                    .padding(.leading, 16)
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: columns) {
                        ForEach(dataFetcher.selectedCategories, id: \.self) { value in
                            Button {
                                
                                if isValue.contains(value){
                                    if let index = isValue.firstIndex(of: value) {
                                        isValue.remove(at: index)
                                    }
                                }else{
                                    isValue.append(value)
                                }
                            } label: {
                                Text(value).tag(value)
                                    .frame(height: 26)
                                    .font(Font.custom("Gilroy-Regular", size: 17))
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 3)
                                    .foregroundColor(isValue.contains(value) ? Color.colors.secondary : Color.gray.opacity(0.8))
                                    .background(
                                        RoundedRectangle(cornerRadius: 10) // Создаем скругленный прямоугольник
                                            .stroke(isValue.contains(value) ? Color.colors.secondary : Color.gray.opacity(0.3), lineWidth: 2)
                                    )
                            }
                            
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.vertical, 10)
                }
                
                //.frame(height: 10)
                
                Text("Цена")
                    .font(Font.custom("Gilroy-Regular", size: 28))
                    .padding(.leading, 16)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    TextField("От", text: $minPriceText)
                        .font(Font.custom("Gilroy-Medium", size: 20))
                        .padding(7)
                        .padding(.horizontal, 5)
                        .background(colorScheme == .light ? Color.white : Color.black)
                        .cornerRadius(8)
                        .padding(.horizontal, 10)

                    
                    TextField("До", text: $maxPriceText)
                        .font(Font.custom("Gilroy-Medium", size: 20))
                        .padding(7)
                        .padding(.horizontal, 5)
                        .background(colorScheme == .light ? Color.white : Color.black)
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                }
                .padding(.bottom, 22)
                
                Text("Искать в Москве")
                    .font(Font.custom("Gilroy-Regular", size: 28))
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                
                TextField("\(Image(systemName: "magnifyingglass"))  Напишите название района", text: $districtsText)
                    .font(Font.custom("Gilroy-Medium", size: 22))
                    .padding(7)
                    .padding(.horizontal, 5)
                    .background(colorScheme == .light ? Color.white : Color.black)
                    .cornerRadius(8)
                    .padding(.horizontal, 10)

                
                Text("Рейтинг исполнителя")
                    .font(Font.custom("Gilroy-Regular", size: 28))
                    .padding(.leading, 16)
                    .padding(.top, 22)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack{
                    ForEach(raiting, id: \.self) { value in
                        Button {
                            minUserRatingText = ""
                            minUserRatingText = value
                        } label: {
                            Text("\(value)")
                                .font(Font.custom("Gilroy-Medium", size: 20))
                                .padding(7)
                                .padding(.horizontal, 5)
                                .cornerRadius(8)
                                .padding(.horizontal, 10)
                                .foregroundColor(value == minUserRatingText ? Color.colors.secondary : Color.gray.opacity(0.8))
                                .background(
                                    RoundedRectangle(cornerRadius: 10) // Создаем скругленный прямоугольник
                                        .stroke(value == minUserRatingText ? Color.colors.secondary : Color.gray.opacity(0.3), lineWidth: 2)
                                )
                        }
                    }
                }
                .padding(.top, 10)
                
                Spacer()
                
                Button {
                    minPrice = Int(minPriceText)
                    maxPrice = Int(maxPriceText)
                    districts.append(districtsText)
                    categories = isValue
                    minUserRating = Int(minUserRatingText)
                    
                    pubService.uploadFilters(minPrice: minPrice, maxPrice: maxPrice, priceTypes: priceTypes, districts: districts, categories: categories, minUserRating: minUserRating)
                    
                    filterIsActive = true
                    
                    
                } label: {
                    Rectangle()
                        .frame(width: 240, height: 50)
                        .foregroundColor(Color.colors.primary)
                        .cornerRadius(16)
                        .overlay {
                            Text("Применить")
                                .font(Font.custom("Gilroy-Regular", size: 22))
                                .foregroundColor(Color.white)
                        }

                }
                .padding(.top, 100)
                //Spacer()
            }
        }
        .onAppear {
            dataFetcher.takeCategoies()
        }
        .padding(.horizontal, 10)
        //.ignoresSafeArea()
        .background(Color.colors.background)
        
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
