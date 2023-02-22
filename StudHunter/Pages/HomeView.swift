//
//  HomeView.swift
//  StudHunter
//
//  Created by Антон Сетямин on 16.02.2023.
//

import SwiftUI

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
    }
}


struct HomeView: View {
    @StateObject var shopVM: ShopViewModel = ShopViewModel()
    @State private var selectedProduct: ProductModel? = nil
    var body: some View {
        ZStack {
            products
                
                //.padding(.vertical)
        }
        .padding(.top,16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
        
    }
}

extension HomeView{
   @ViewBuilder private var products: some View{
       let columns:[GridItem] = [GridItem(.fixed(Settings.shared.productCardSize), spacing: 15, alignment: nil),
                    GridItem(.fixed(Settings.shared.productCardSize), spacing: 15, alignment: nil)]
        ScrollView(.vertical, showsIndicators: true){
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 15,
                      pinnedViews: []) {
                ForEach(shopVM.products){product in
                    NavigationLink{
                        ProductDetailView(product: product)
                    }label:{
                        ProductsCardView(product: product)
                    }
                }
                
                // na vsyakiy pojarniy
                
                
//                    ProductsCardView(product: product)
//                        .onTapGesture {
//                            selectedProduct = product
//                        }
//                }
                //.sheet(item: $selectedProduct) { product in
                //    ProductDetailView(product: product)
                //}
            }
        }
    }
}
