//
//  HomeView.swift
//  StudHunter
//
//  Created by Антон Сетямин on 16.02.2023.
//

import SwiftUI


struct HomeView: View {
    @ObservedObject var data: Requesting
    @State private var filtersVM: FiltersViewModel?
    
    @Environment(\.presentationMode) var mode
  
    
    let columns:[GridItem] = [GridItem(.fixed(Settings.shared.productCardSize), spacing: 28, alignment: nil),
                              GridItem(.fixed(Settings.shared.productCardSize), spacing: 20, alignment: nil)]
    @State private var text = ""
    @State private var isEditing:Bool = false
    @Binding  var selectedTab: TabItems
    
    @State private var showModal = false
    
    @State private var searchText = ""
    @State private var searchCategories = ""
    @State private var isSearching = false
    @State private var searchResults: [JSData] = []
    @State private var searchResultsCategories: [JSData] = []
    @State private var basicList: [JSData] = []
    @State private var selectedCategory = ""
    @State private var selectedCategoryNew = ""
    @StateObject private var dataFetcher = DataFetcher()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0){
                topBar
                ScrollView{
                    LazyVGrid(columns: columns) {
                        if searchText.isEmpty && selectedCategory.isEmpty{
                            ForEach(data.dataBase ?? [JSData](), id: \.id){ data in
                                ZStack{
                                    NavigationLink {
                                        
                                        FullCardView(correctId:data, changePubFavoriteStatusRequest: ChangePubFavoriteStatusRequest(publicationId: ""))
                                    } label: {
                                        VStack{
                                            AsyncImage(url: URL(string: data.imageURL)){image in
                                                image
                                                    .resizable()
                                                    .frame(maxWidth:190, maxHeight: 170,alignment: .top)
                                            }placeholder: {
                                                Image(systemName: "photo")
                                                    .frame(width: 100, height: 170, alignment: .center)
                                            }
                                            
                                            Text("\(data.price ?? 0) \(data.priceType)")
                                                .foregroundColor(Color.colors.black)
                                                .padding(.top, 1)
                                                .padding(.leading, 8)
                                                .font(Font.custom("Gilroy-Semibold", size: 19))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
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
                                            
                                            Text(data.timestamp.millsToDateTime()!)
                                                .foregroundColor(Color.colors.grey)
                                                .font(Font.custom("Gilroy-Regular", size: 14))
                                                .padding(8)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            
                                            Spacer()
                                            
                                        }
                                        .frame(width: 190, height: 290)
                                        .background(Color.colors.white)
                                        .cornerRadius(16)
                                        .shadow(color: Color.init(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.08), radius: 6, x: 0, y: 4)
                                    }
                                    .padding(.top, 8)
                                }
                                .ignoresSafeArea()
                            }
                        }else{
                            ForEach(searchResults ?? [JSData](), id: \.id){ data in
                                ZStack{
                                    NavigationLink {
                                        FullCardView(correctId:data, changePubFavoriteStatusRequest: ChangePubFavoriteStatusRequest(publicationId: ""))
                                    } label: {
                                        VStack{
                                            AsyncImage(url: URL(string: data.imageURL)){image in
                                                image
                                                    .resizable()
                                                    .frame(maxWidth:190, maxHeight: 170,alignment: .top)
                                            }placeholder: {
                                                Image(systemName: "photo")
                                                    .frame(width: 100, height: 170, alignment: .center)
                                            }
                                            
                                            Text("\(data.price ?? 0) \(data.priceType)")
                                                .foregroundColor(Color.colors.black)
                                                .padding(.top, 1)
                                                .padding(.leading, 8)
                                                .font(Font.custom("Gilroy-Semibold", size: 19))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
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
                                            
                                            Text(data.timestamp.millsToDateTime()!)
                                                .foregroundColor(Color.colors.grey)
                                                .font(Font.custom("Gilroy-Regular", size: 14))
                                                .padding(8)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            
                                            Spacer()
                                            
                                        }
                                        .frame(width: 190, height: 290)
                                        .background(Color.colors.white)
                                        .cornerRadius(16)
                                        .shadow(color: Color.init(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.08), radius: 6, x: 0, y: 4)
                                        
                                    }
                                    .padding(.top, 8)
                                }
                                .ignoresSafeArea()
                            }
                        }
                    }.onAppear(){
                        data.request()
                    }
                }
                tabBar
            }
            .ignoresSafeArea()
            .background(Color.colors.background.ignoresSafeArea())
        }
        .sheet(isPresented: $showModal) {
            SheetView()
        }
    }
    private var topBar: some View{
        HStack{
            TextField("\(Image(systemName: "magnifyingglass"))  Search", text: $searchText)
                .padding(7)
                .padding(.horizontal, 5)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            Button {
                showModal.toggle()
            } label: {
                Image(systemName: "list.dash")
                    .foregroundColor(Color.colors.grey)
            }

//            if searchText == "" {
//                Menu {
//                    Picker("Select Category", selection: $selectedCategory) {
//                        ForEach(dataFetcher.selectedCategories, id: \.self) { value in
//                            Text(value).tag(value)
//                        }
//
//                    }
//                    .padding()
//                        }label: {
//                            if selectedCategory == ""{
//                                Image(systemName: "list.dash")
//                                    .foregroundColor(Color.colors.grey)
//                            }else{
//                                Image(systemName: "trash")
//                                    .foregroundColor(Color.colors.grey)
//                            }
//                        }
//                        .onTapGesture {
//                            helper()
//
//                        }
//                        .onChange(of: selectedCategory) { _ in
//                            Task {
//                                selectedCategoryNew = selectedCategory
//                            }
//
//                        }
//                        .onChange(of: selectedCategoryNew) { _ in
//                            Task {
//                                selectedCategoryNew = selectedCategory
//                                performSearchForCategories()
//                            }
//
//                        }
//                        .onAppear {
//                            dataFetcher.takeCategoies()
//                        }
//            }else{
//                Button(action: performSearch) {
//                    Text("Поиск")
//                }
//                .padding(.trailing, 20)
//
//            }
        }
        .padding(.horizontal,20)
        .padding(.top,56)
        .padding(.bottom,26)
        .background(Color.colors.white)
        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
        
        
        
    }



//    struct HomeView_Previews: PreviewProvider {
//        static var previews: some View {
//            NavigationView{
//                HomeView(data: Requesting(), selectedTab: $selectedTab)
//            }
//        }
//    }
}

extension HomeView{
    private var tabBar: some View{
        HStack{
            ForEach(TabItems.allCases, id: \.self){ tabItems in
                ZStack{
                    if selectedTab == tabItems{
                    }
                    Image(systemName: tabItems.rawValue)
                        .font(.system(size: 25))
                        .foregroundColor(selectedTab == tabItems ? Color.colors.secondary : Color.colors.grey)
                    Spacer()
                    if tabItems == .home{
                        Text("Главная")
                            .padding(.top,50)
                            .font(.system(size: 10))
                    }else if tabItems == .add{
                        Text("Добавить")
                            .padding(.top,50)
                            .font(.system(size: 10))
                    }else if tabItems == .categories{
                        Text("Категории")
                            .padding(.top,50)
                            .font(.system(size: 10))
                    }else if tabItems == .best{
                        Text("Избранное")
                            .padding(.top,50)
                            .font(.system(size: 10))
                    }else if tabItems == .profile{
                        Text("Профиль")
                            .padding(.top,50)
                            .font(.system(size: 10))
                    }
                }
                .padding(.bottom, 40)
                .foregroundColor(selectedTab == tabItems ? Color.colors.secondary : Color.colors.grey)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    withAnimation(.linear){
                        selectedTab = tabItems
                    }
                }
            }
        }
    
        .background(Color.colors.white).cornerRadius(24, corners: [.topLeft, .topRight])
        .ignoresSafeArea()
        .frame(width: UIScreen.main.bounds.width, height:80)
        .padding(.horizontal, 28)
        .frame(width: UIScreen.main.bounds.width, height: 86)
        //.opacity(showTabBar ? 0 : 1)
        
        
        
        
        
        
        
    }

    
    func helper(){
        if selectedCategory == selectedCategoryNew{
            selectedCategory = ""
        }
    }
    
    func performSearch() {
       
       let searchString = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
       let searchStrings = searchString.components(separatedBy: " ")
       
       searchResults = searchItems(data.dataBase, searchStrings: searchStrings)

   }
    
    func performSearchForCategories() {
       
       let searchString = selectedCategory.trimmingCharacters(in: .whitespacesAndNewlines)
       let searchStrings = searchString.components(separatedBy: " ")
       
       searchResults = searchItems(data.dataBase, searchStrings: searchStrings)

   }
    
    private func searchItems(_ items: [JSData], searchStrings: [String]) -> [JSData] {
        return items.filter { item in
            searchStrings.allSatisfy { searchString in
                item.description.range(of: searchString, options: .caseInsensitive) != nil ||
                item.title.range(of: searchString, options: .caseInsensitive) != nil ||
                item.priceType.range(of: searchString, options: .caseInsensitive) != nil ||
                item.category.range(of: searchString, options: .caseInsensitive) != nil
            }
        }
    }
    
    var categoriesLabel: some View {
        HStack {
            Text(selectedCategory)
                .padding(.leading, 20)
            Spacer()
            Text("⌵")
                .offset(y: -4)
                .offset(x: -16)
        }
        .foregroundColor(.black)
        //.padding(.bottom,20)
        .font(Font.custom("Gilroy-Regular", size: 20))
        .frame(width: 396, height: 54)
        .cornerRadius(16)
        }
}


extension TimeInterval {
    func millsToDateTime() -> String? {
        let date = Date(timeIntervalSince1970: self / 1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy, HH:mm"
        formatter.locale = Locale.current
        return formatter.string(from: date)
    }
    
}
