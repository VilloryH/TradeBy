import SwiftUI
import SDWebImageSwiftUI

struct LatestComponentView: View {
    var backgroundImage: URL
    var price: String
    var productName: String
    var category: String
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text(category)
                        .font(.caption2)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(5)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30))
                    Text(productName)
                        .fontWeight(.bold)
                        .font(.caption2)
                        .foregroundColor(.white)
                    HStack {
                        Text("$ \(price)")
                            .font(.caption2)
                            .foregroundColor(.white)
                        Spacer()
                        Circle()
                            .background(.ultraThinMaterial)
                            .shadow(radius: 5)
                            .overlay(Image(systemName: "plus")
                                .foregroundColor(.black))
                            .frame(width: 25, height: 25)
                            .mask(Circle())
                    }.padding(.horizontal,5)
                }
                .padding(5)
            }
            .background (
                Rectangle().fill(.clear)
                    .frame(width: 125)
                    .overlay (
                        WebImage(url: backgroundImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.horizontal)
                            .ignoresSafeArea()
                    )
            )
            .mask (
                Rectangle()
                    .cornerRadius(10)
                    .frame(height: 200)
)
        }.frame(width: 125, height: 200)
            .cornerRadius(5)
        
    }
}
