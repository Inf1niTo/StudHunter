//
//  ProductDetailView.swift
//  StudHunter
//
//  Created by Антон Сетямин on 19.02.2023.
//

import SwiftUI

//struct ProductDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetailView()
//    }
//}


struct ProductDetailView: View {
    @Environment(\.presentationMode) private var mode
    @EnvironmentObject private var shopVM: ShopViewModel
    let product: ProductModel
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0){
                topBar
               // images
                productImages
                // product data
                VStack(alignment: .leading, spacing: 5) {
                    
                    productCost
                    //uploadProductData
                    //
                    productLocation
                    
                    productName
                    
                    productDescription
                    
                    productProfile
                    
                    Spacer()
                    
                    HStack(){
                        Spacer()
                        
                            callButton
                        
                        Spacer()
                        
                            messageButton
                        
                        Spacer()
                    }
                }
                .padding([.horizontal,.vertical])
                Spacer()
                
            }
            .padding(.bottom, 20)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colors.background.ignoresSafeArea())
    }
}

extension ProductDetailView{
    //product images
    private var productImages: some View{
        TabView{
            
            Image(product.image)
                
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 248)
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .padding(.top, 20)
    }
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
            .font(Font.custom("Gilroy-Medium", size: 21))
    }
    private var productCost: some View{
        Text("\(product.cost.twoDecimaPlaces()) ₽")
            .foregroundColor(Color.colors.black)
            .padding(8)
            .font(Font.custom("Gilroy-Medium", size: 21))
    }
    private var productDescription: some View{
        Text(product.description)
            .foregroundColor(Color.colors.black)
            .padding(.leading,8)
            .font(Font.custom("Gilroy-Regular", size: 19))
    }
    
    private var productDate: some View{
        Text(product.date)
            .foregroundColor(Color.colors.grey)
            .font(Font.custom("Gilroy-Regular", size: 12))
            .padding(8)
    }
    
    private var productLocation: some View{
        HStack{
            Image(systemName: "mappin.circle")
            Text(product.location)
                .foregroundColor(Color.colors.black)
                .font(Font.custom("Gilroy-Medium", size: 15))
                
        }
        .padding(8)
    }
    private var productProfile: some View{
        ZStack{
            HStack{
                Image(systemName: "person.circle")
                    .font(.system(size: 43))
                VStack(alignment: .leading){
                    Text("Анжелла Крупчатникова")
                        .foregroundColor(Color.colors.black)
                        .font(Font.custom("Gilroy-Regular", size: 17))
                    
                    
                    Text("Рейтинг 5.0")
                        .foregroundColor(Color.colors.green)
                        .font(Font.custom("Gilroy-Regular", size: 15))
                }
            }
        }
        .padding(8)
    }
    
    private var uploadProductData: some View {
        Button(action: {
            shopVM.uploadProductData(product: product)
        }) {
            Image(systemName: "arrow.up")
                .foregroundColor(Color.colors.black)
        }
        
    }
    
    private var callButton: some View {
        Button(action: {
            //
        }) {
            HStack{
                Text("Позвонить")
                    .frame(width: 158, height: 46, alignment: .center)
                    .background(Color.colors.primary)
                    .foregroundColor(Color.colors.white)
            }
            .cornerRadius(12)
        }
        
    }
    private var messageButton: some View {
        Button(action: {
            //
        }) {
            HStack{
                Text("Написать")
                    .frame(width: 158, height: 46, alignment: .center)
                    .background(Color.colors.primary)
                    .foregroundColor(Color.colors.white)
            }
            .cornerRadius(12)
        }
    }
    
    private var topBar: some View{
        HStack(spacing: 0){
            Button {
                mode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.colors.black)
            }
            .padding(.top,30)
            
            Spacer()
            
            Button {
                //add in fovourite
            } label: {
                Image(systemName: "heart")
                    .foregroundColor(Color.colors.black)
            }
            .padding(.top,30)
        }
        .padding(30)
        .background(Color.colors.white)
        .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
    }
}
// Для краев таб бара
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
