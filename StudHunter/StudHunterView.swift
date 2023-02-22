//
//  ContentView.swift
//  StudHunter
//
//  Created by Антон Сетямин on 16.02.2023.
//

import SwiftUI

enum TabItems: String, CaseIterable{
    case home = "circle.grid.2x2"
    case categories = "line.3.horizontal"
    case add = "plus.circle"
    case best = "heart"
    case profile = "person"
}
enum TabItemsText: String, CaseIterable{
    case home = "hbvhw"
    case add = "list.bullet"
    case best = "cart.fill"
    case profile = "person.crop.circle.fill"
    case categories = "person.circle"
}

struct StudHunterView: View {
    //@ObservedObject var shopVM: ShopViewModel
    @Namespace private var TabBarNameSpace
    @State private var text = ""
    @State private var isEditing:Bool = false
    @State private var selectedTab: TabItems = .add
    var body: some View {
        NavigationView{
            ZStack {
                VStack(spacing: 0){
                    topBar
                    
                    //show page
                    pages
                    
                    //tab bar
                    tabBar
                    
                }
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.colors.background.ignoresSafeArea())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StudHunterView()
    }
}
extension StudHunterView{
    @ViewBuilder private var pages: some View{
        switch selectedTab{
        case .home:
            HomeView()
        case .add:
            AddView()
        case .best:
            BestView()
        case .profile:
            ProfileView()
        case .categories:
            CategoriesView()
            
        }
    }
    //bottom tab bar
    private var tabBar: some View{
        HStack{
            ForEach(TabItems.allCases, id: \.self){ tabItems in
                ZStack{
                    if selectedTab == tabItems{
                        //RoundedRectangle(cornerRadius: 10)
                            //.fill(Color.colors.background)
                            //.matchedGeometryEffect(id: "tabs", in: TabBarNameSpace)
                        
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
        
        
        
        
    }
    private var topBar: some View{
        HStack {
  
             TextField("\(Image(systemName: "magnifyingglass"))  Поиск", text: $text)
                 .padding(7)
                 .padding(.horizontal, 5)
                 .background(Color(.systemGray6))
                 .cornerRadius(8)
                 .padding(.horizontal, 10)
                 .onTapGesture {
                     self.isEditing = true
                 }
  
            if isEditing {
                 Button(action: {
                     self.isEditing = false
                     self.text = ""
  
                 }) {
                     Text("Cancel")
                 }
                 .padding(.trailing, 10)
                 .transition(.move(edge: .trailing))
                 //.animation(.default)
             }
            Button {
                //
            } label: {
                Image(systemName: "list.dash")
                    .foregroundColor(Color.colors.grey)
            }

         }
        .padding(.horizontal,20)
        .padding(.top,56)
        .padding(.bottom,26)
        .background(Color.colors.white)
        .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
        
    }
}
