import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @EnvironmentObject private var coordinator: Coordinator
    var body: some View {
        ZStack {
            Color(.white).edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 8) {
                    Text("Profile").bold()
                        .padding()
                    Image("Imaggg")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .cornerRadius(64)
                    Button {
                        
                    } label: {
                        Text("Change photo")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Text("Vitaliy Petrovskiy")
                        .font(.title.weight(.semibold))
                        .padding()
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Upload item")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 300, height: 60)
                            .background(Color("DarkPurple"), in: RoundedRectangle(cornerRadius: 25, style: .continuous))
                    }.padding()
     
                    VStack(spacing: 20) {
                        ForEach(settings) { item in
                            HStack {
                                Circle()
                                    .fill(.gray.opacity(0.5))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                Image(systemName: item.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .mask(Circle()
                                        .frame(width: 40, height: 40))
                                    )
                                    
                                Text(item.name)
                                Spacer()
                                if item.arrow {
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15, height: 15)
                                }
                                Text(item.text ?? "")
                            }.onTapGesture {
                                if item.name == "Log out" {
                                    coordinator.dismissFullscreenCover()
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            .padding()
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
        
    }
}
