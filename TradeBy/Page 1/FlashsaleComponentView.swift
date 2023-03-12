import SwiftUI
import SDWebImageSwiftUI

struct FlashsaleComponentView: View {
    var backgroundImage: URL
    var price: String
    var productName: String
    var category: String
    var discount: String
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("\(discount)% off")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.caption)
                        .padding(5)
                        .background(.red, in: RoundedRectangle(cornerRadius: 30))
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text(category)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.caption)
                        .padding(5)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30))
                    Text(productName)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    HStack {
                        Text("$ \(price)")
                            .foregroundColor(.gray)
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
            .frame(width: 180, height: 300)
        }
        .background (
            Rectangle().fill(.clear)
              
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
                .frame(height: 300)
)
        
    }
}
