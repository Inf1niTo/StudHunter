//
//  ProductsCardView.swift
//  StudHunter
//
//  Created by Антон Сетямин on 17.02.2023.
//

import SwiftUI

//struct ProductsCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductsCardView()
//    }
//}


struct ProductsCardView: View {
    let product: ProductModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            productImage
        
            productCost
            
            productName
            
            productDescription
            
            productDate
            
        }
        .background(Color.colors.white)
        .cornerRadius(16)
        .shadow(color: Color.init(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.04), radius: 6, x: 0, y: 4)
        
    }
        
}

extension ProductsCardView{
    //product image
    private var productImage: some View{
        Image(product.image)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .frame(width: Settings.shared.productCardSize, height: Settings.shared.productCardSize)
    }
    //
    private var productArticle: some View{
        Text(product.article)
            .foregroundColor(Color.colors.black)
            .font(Font.custom("Gilroy-Medium", size: 12))
    }
    private var productBrand: some View{
        Text(product.brands.rawValue)
            .foregroundColor(Color.colors.black)
            .font(Font.custom("Gilroy-Medium", size: 12))
    }
    private var productName: some View{
        Text(product.name)
            .foregroundColor(Color.colors.black)
            .padding(.leading,8)
            .font(Font.custom("Gilroy-Medium", size: 16))
    }
    private var productCost: some View{
        Text("\(product.cost.twoDecimaPlaces()) ₽")
            .foregroundColor(Color.colors.black)
            .padding(8)
            .font(Font.custom("Gilroy-Semibold", size: 16))
    }
    private var productDescription: some View{
        Text(product.description)
            .foregroundColor(Color.colors.black)
            .padding(.leading,8)
            .font(Font.custom("Gilroy-Regular", size: 16))
    }
    private var productDate: some View{
        Text(product.date)
            .foregroundColor(Color.colors.grey)
            .font(Font.custom("Gilroy-Regular", size: 12))
            .padding(8)
    }
}
