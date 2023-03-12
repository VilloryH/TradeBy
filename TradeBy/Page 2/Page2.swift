import SwiftUI
import SDWebImageSwiftUI

struct Page2View: View {
    @ObservedObject var viewModel = NetworkViewModel()
    @EnvironmentObject private var coordinator: Coordinator
    @State var count = 0
    @State var show: Bool
    @State var indexImage = 0
    @State private var isExpanded: [Bool] = [true, false, false]
    var body: some View {
        
        if show {
            ZStack {
                VStack {
                    HStack {
                        Button {
                            show.toggle()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }.padding(.horizontal)
                    content
                }
                .onAppear {
                    viewModel.fetchData(dataType: .additional)
                }
            }
            
        } else {
            
            CoordinatorView()
            
        }
        
    }
    
    var content: some View {
        VStack(spacing: 30) {
            
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.clear)
                .padding(.horizontal)
                .frame(width: 360, height: 250)
                .overlay(
                    ForEach(viewModel.dataAdditional.imageUrls.prefix(3).indices, id: \.self) { index in
                        if isExpanded[index] == true {
                            WebImage(url: viewModel.dataAdditional.imageUrls[index])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                                .mask(RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 300, height: 250)
                                )
                        }
                    }
                        .overlay(
                            HStack {
                                Spacer()
                                VStack {
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "heart")
                                    }.padding(.vertical)
                                    Divider()
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "arrowshape.turn.up.right")
                                    }.padding(.vertical)

                                }.foregroundColor(.blue)
                                    .padding(.vertical, 30)
                                    .frame(width: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray).opacity(0.5))
                            }
                        )
                )
            HStack(spacing: 2) {
                ForEach(viewModel.dataAdditional.imageUrls.prefix(3).indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .frame(width: isExpanded[index] ? 100 : 70, height: isExpanded[index] ? 60 : 40)
                        .overlay(
                            WebImage(url: viewModel.dataAdditional.imageUrls[index])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .mask(RoundedRectangle(cornerRadius: 15)
                                    .frame(width: isExpanded[index] ? 100 : 70, height: isExpanded[index] ? 60 : 40)
                                )
                        )
                        .onTapGesture {
                            withAnimation {
                                isExpanded[index].toggle()
                                for i  in 0..<isExpanded.count {
                                    if i != index {
                                        isExpanded[i] = false
                                    }
                                }
                            }
                        }
                }
            }
            HStack {
                Text(viewModel.dataAdditional.name)
                    .font(.title3)
                    .bold()
                Spacer()
                Text("$ \(viewModel.dataAdditional.price)")
                    .bold()
            }.padding(.horizontal)
            HStack {
                Text(viewModel.dataAdditional.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(width: 200, alignment: .leading)
                Spacer()
            }.padding(.horizontal)
            
            HStack(spacing: 2) {
                Image(systemName: "star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .foregroundColor(.yellow)
                Text("\(String(format: "%.1f", viewModel.dataAdditional.rating))")
                    .font(.caption)
                    .bold()
                Text("(\(viewModel.dataAdditional.numberOfReviews) reviews)")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }.padding(.horizontal)
            VStack {
                HStack {
                    Text("Color:")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .bold()
                    Spacer()
                }.padding(.horizontal)
                HStack {
                    ForEach(viewModel.dataAdditional.colors.prefix(3), id: \.self) { color in
                        let coloring = Color(color)
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.gray)
                            .frame(width: 42, height: 32)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(coloring ?? .black)
                                    .frame(width: 40, height: 30)
                            )
                    }
                    Spacer()
                }.padding(.horizontal)
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .frame(width: UIScreen.main.bounds.width)
                        .edgesIgnoringSafeArea(.bottom)
                        .overlay(
                            VStack {
                                HStack {
                                    VStack {
                                        Text("Quantity:")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        HStack {
                                            Button {
                                                if count > 0 {
                                                    count -= 1
                                                }
                                            } label: {
                                                Text("-")
                                                    .foregroundColor(.white)
                                                    .padding(.vertical, 3)
                                                    .padding(.horizontal, 15)
                                                    .background(RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color("DarkPurple")))
                                            }
                                            Text(count < 1 ? "" : "\(count)")
                                                .foregroundColor(.white)
                                                .font(.caption)
                                                .bold()
                                                .padding()
                                            Button {
                                                count += 1
                                            } label: {
                                                Text("+")
                                                    .foregroundColor(.white)
                                                    .padding(.vertical, 3)
                                                    .padding(.horizontal, 15)
                                                    .background(RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color("DarkPurple")))
                                            }
                                            
                                        }
                                    }
                                    Spacer()
                                    Button {
                                        
                                    } label: {
                                        HStack {
                                            Text("#2,500")
                                                .foregroundColor(.gray)
                                                .font(.caption)
                                            
                                            Text("Add to cart")
                                                .foregroundColor(.white)
                                                .bold()
                                        }
                                        .frame(width: 200, height: 70)
                                        .background(RoundedRectangle(cornerRadius: 20)
                                            .fill(Color("DarkPurple")))
                                    }
                                }.padding()
                            }
                        )
                }
            }
            
        }
    }
}

struct Page_2_Previews: PreviewProvider {
    static var previews: some View {
        Page2View(show: false)
    }
}
