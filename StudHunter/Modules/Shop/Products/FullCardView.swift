//
//  FullCardView.swift
//  StudHunter
//
//  Created by Антон Плотников on 06.06.2023.
//

import SwiftUI
import ImageViewer
import ImageViewerRemote


struct FullCardView: View {
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var colorScheme
    
    var correctId: JSData
    
    @State private var fullCardData: FullCardData?
    
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var nickname: String = ""
    @State private var raiting: String = ""
    
    @State private var mainImage: String = ""
    @State private var priceType: String = ""
    @State private var price: Int = 0
    @State private var title: String = ""
    @State private var description: String = ""
    
    @State var changePubFavoriteStatusRequest:ChangePubFavoriteStatusRequest
    
    @State private var id: String = ""
    
    @State var count = 1
    
    @State var showIndex = false
    
    @State var isFavourite = false
    
    @State var numImages = 3
    
    @State var images: [Image?] = []
    
    @State var image = Image("example-image")
    
    @State private var availableImageCount: Int = 0

    @State var showImageViewer: Bool = false
    
    var body: some View{
            ZStack{
                    VStack(spacing: 0){
                        topBar
                        
                        ScrollView(showsIndicators: false){
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(){
                                    
                                    ForEach(0..<3) { num in
                                        
                                        AsyncImage(url: URL(string: mainImage.replacingOccurrences(of: "/0", with: "/\(num)"))){image in
                                            
                                            switch image{
                                                
                                            case .empty:
                                            placeholder: do {
                                                Rectangle()
                                                    .stroke(Color.gray, lineWidth: 1)
                                                    .frame(width:380 ,height: 248)
                                                    .cornerRadius(16)
                                                    .padding(.horizontal, 16)
                                                    .padding(.top, 20)
                                                
                                            }
                                                
                                            default:
                                                Button {
                                                    showImageViewer = true
                                                    self.image = image.image!
                                                } label: {
                                                    image.image?
                                                        .resizable()
                                                        .scaledToFill()
                                                        .tabViewStyle(PageTabViewStyle())
                                                        .frame(width:380 ,height: 248)
                                                        .cornerRadius(16)
                                                        .padding(.horizontal, 16)
                                                        .padding(.top, 20)
                                                        .onAppear(){
                                                            images.append(image.image)
                                                        }
                                                        .overlay {
                                                            VStack{
                                                                Rectangle()
                                                                    .opacity(0.7)
                                                                    .overlay {
                                                                        Text("\(num+1)")
                                                                            .foregroundColor(Color.black)
                                                                    }
                                                                    .foregroundColor(.gray)
                                                                    .cornerRadius(8)
                                                                    .frame(width: 40, height: 20)
                                                                    .padding(.trailing, 295)
                                                                    .padding(.top, 210)
                                                                
                                                                
                                                            }
                                                        }
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                            Text("\(price) \(priceType)") //price
                                .foregroundColor(Color.colors.black)
                                .padding(10)
                                .padding(.leading, 14)
                                .font(Font.custom("Gilroy-Medium", size: 24))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            Text(title) //title
                                .foregroundColor(Color.colors.black)
                                .padding(.leading,22)
                                .font(Font.custom("Gilroy-Medium", size: 25))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            Text(description)
                                .lineLimit(nil)
                                .foregroundColor(Color.colors.black)
                                .padding(.top,10)
                                .font(Font.custom("Gilroy-Regular", size: 19))
                                .padding(.leading,22)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 30)
                            
                            HStack {
//                                AsyncImage(url: URL(string:"https://storage.yandexcloud.net/stud-hunter-bucket/users/avatars/\(id)")){image in
//
//                                    switch image{
//
//                                    case .empty:
//                                    placeholder: do {
//                                        Image(systemName: "person.circle")
//                                            .font(.system(size: 60))
//                                            .padding(.leading, 2)
//                                            .foregroundColor(colorScheme == .light ? Color.black : Color.white)
//                                    }
//
//                                    default:
//                                        Button {
//                                            showImageViewer = true
//                                            self.image = image.image!
//                                        } label: {
//                                            image.image?
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width:60 ,height: 60)
//                                                .cornerRadius(90)
//                                                .padding(.leading, 2)
//
//                                        }
//                                    }
  //                              }
                                if id != ""{

                                        Image(systemName: "person.circle")
                                            .font(.system(size: 60))
                                            .padding(.leading, 2)
                                            .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                            .overlay{
                                                AsyncImage(url: URL(string:"https://storage.yandexcloud.net/stud-hunter-bucket/users/avatars/\(id)")){image in
                                                    image.image?
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width:60 ,height: 60)
                                                        .cornerRadius(90)
                                                        .padding(.leading, 2)
                                                }
                                        }
                                    }else{
                                    Image(systemName: "person.circle")
                                        .font(.system(size: 60))
                                        .padding(.leading, 2)
                                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                    }
                                VStack(spacing: 5){
                                    HStack{
                                        Text(fullCardData?.user.name ?? "")
                                        
                                        Text(fullCardData?.user.surname ?? "") //rating
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    Text("Рейтинг: \(raiting)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                               }
                            }
                            .padding(.leading, 20)
                            .onAppear(){
                                changePubFavoriteStatusRequest = ChangePubFavoriteStatusRequest(publicationId: correctId.id)
                                
                                Requesting().takeFullCardData(id: correctId.id) { loadedFullCardData in
                                    if let loadedFullCardData = loadedFullCardData {
                                        DispatchQueue.main.async {
                                            fullCardData = loadedFullCardData
                                            mainImage = loadedFullCardData.publication.imageUrl
                                            priceType = loadedFullCardData.publication.priceType
                                            price = loadedFullCardData.publication.price ?? 0
                                            title = loadedFullCardData.publication.title
                                            description = loadedFullCardData.publication.description
                                            name = loadedFullCardData.user.name
                                            let num = loadedFullCardData.user.rating
                                            raiting = String(format: "%.1f", num)
                                            id = loadedFullCardData.user.id
                                            
                                            debugPrint("dodododododod\(id)")
                                        }
                                            } else {
                                // Обработка ошибки, если не удалось загрузить профиль
                                                debugPrint("no dodododododod")
                                                }
                                }
                                
                                Requesting().checkPubFavoriteStatus(pubID: correctId.id){ result in
                                    switch result {
                                        case .success(let isFavorite):
                                            if isFavorite {
                                                isFavourite = true
                                                print("Publication is in favorites")
                                            } else {
                                                isFavourite = false
                                                print("Publication is not in favorites")
                                            }
                                        case .failure(let error):
                                            // Handle the error if it occurred during the request
                                            print("Error: \(error.localizedDescription)")
                                        }
                                    }
                            }

                        HStack{
                            messageButton
                                .padding(.top, 30)
                        }
                        .padding(.bottom, 40)
                        
                        Spacer()
                    }
                }
            }
        

            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .overlay(ImageViewer(image: $image, viewerShown: self.$showImageViewer, closeButtonTopRight: true))
            .background(Color.colors.background.ignoresSafeArea())
            }
    
        }
extension FullCardView{
    // для обработки наличия фоток на сервере
    func countAvailableImages(completion: @escaping (Int) -> Void) {
        var count = 0
        let group = DispatchGroup()

        for num in 0..<numImages {
            let imageURL = URL(string: correctId.imageURL.replacingOccurrences(of: "_0", with: "_\(num)"))

            group.enter()
            URLSession.shared.dataTask(with: imageURL!) { data, response, error in
                if let imageData = data, let _ = UIImage(data: imageData) {
                    count += 1
                }
                group.leave()
            }.resume()
        }

        group.notify(queue: .main) {
            completion(count)
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
                if isFavourite == true{
                    Requesting().removePubFromFavorite(changePubFavoriteStatusRequest: changePubFavoriteStatusRequest) { result in
                        isFavourite = false
                    }
                }else{
                    Requesting().addPubToFavorite(changePubFavoriteStatusRequest: changePubFavoriteStatusRequest) { result in
                        isFavourite = true
                    }
                }
            } label: {
                Image(systemName: "heart")
                    .foregroundColor(isFavourite == false ? Color.colors.black : Color.colors.red)
            }
            .padding(.top,30)
        }
        .padding(30)
        .background(Color.colors.white)
        .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
    }
        private var messageButton: some View {
            Button(action: {
                
            }) {
                HStack{
                    Text("Написать")
                        .frame(width: 358, height: 56, alignment: .center)
                        .background(Color.colors.primary)
                        .foregroundColor(Color.white)
                }
                .cornerRadius(12)
            }
        }

}
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

//struct FullCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullCardView(correctId: JSData(id: "any id", imageURL: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dfstudio.com%2Fdigital-image-size-and-resolution-what-do-you-need-to-know%2F&psig=AOvVaw26B6srOKy9OaNznPHMcfgK&ust=1692203047607000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCPiFy9-J34ADFQAAAAAdAAAAABAE", title: "title", description: "opisanie", price: 100, priceType: "p", district: "hz", timestamp: 0.1, category: "hz", userID: "hz", socials: "1"))
//    }
//}

