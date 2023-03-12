import SwiftUI

struct Page1: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = NetworkViewModel()
    @State private var rightData = false
    @EnvironmentObject private var coordinator: Coordinator
    @State private var showDropdown = false
    @State var showAdd = false
    let semaphore = DispatchSemaphore(value: 1)
    var body: some View {
        
            if !showAdd {
                ZStack {
                Color.white.ignoresSafeArea(.all)
                ScrollView(showsIndicators: false) {
                    VStack {
                        topElements
                        searchBar
                        categoriesView
                        latestView
                        flashSaleView
                        brandsView
                    }.onAppear(perform: {
                        DispatchQueue.main.async {
                            viewModel.fetchData(dataType: .latest)
                            semaphore.wait()
                            sleep(1)
                            semaphore.signal()
                            viewModel.fetchData(dataType: .flashSale)
                            semaphore.wait()
                            sleep(1)
                            semaphore.signal()
                            viewModel.fetchData(dataType: .words)
                        }
                        if !viewModel.dataFlash.isEmpty && !viewModel.dataLatest.isEmpty {
                            rightData = false
                        }
                        else {
                            rightData = true
                        }
                    })
                }
            }
           
        }
        else {
                Page2View(show: true)
        }
    }
    
    var topElements: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "line.3.horizontal")
                Spacer()
                HStack {
                    Text("Trade by")
                        .font(.largeTitle).bold()
                    Text("bata")
                        .font(.largeTitle).bold()
                        .foregroundColor(Color("DarkPurple"))
                }
                Spacer()
                VStack {
                    Circle().fill(.gray)
                        .frame(width: 50, height: 50)
                        .overlay (
                            
                            Button {
                               
                            } label: {
                                Image("Imaggg")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .mask(Circle())
                            }
                            
                            
                            
                        )
                }
            }
            HStack {
                Spacer()
                Text("Location")
                    .font(.caption)
                Image(systemName: "chevron.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
            }
        }.padding(20)
    }
    
    var searchBar: some View {
        VStack {
            HStack {
                TextField("", text: $searchText, onEditingChanged: { isEditing in
                    if isEditing {
                        showDropdown = true
                    } else {
                        showDropdown = false
                    }
                })
                .onChange(of: searchText) { text in
                    if viewModel.dataWords.contains(text) {
                        showDropdown = true
                    }
                }
                
                .placeholder(when: searchText.isEmpty) {
                    Text("What are you looking for?")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.gray)
                }
                Image(systemName: "magnifyingglass")
            }.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal, 40)
            
            if showDropdown {
                ForEach(viewModel.dataWords.filter({$0.hasPrefix(searchText)}), id: \.self) { word in
                    Text(word)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            searchText = word
                            showDropdown = false
                        }
                }
                .frame(minWidth: 0)
            }
            
        }
    }
    
    var categoriesView: some View {
        VStack {
            HStack {
                ForEach(categories) { categorie in
                    VStack {
                        Button {
                            
                        } label: {
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: categorie.image)
                                )
                        }
                        .foregroundColor(.black)
                        Text(categorie.name)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }.padding(.vertical)
    }
    
    var latestView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Latest")
                    .foregroundColor(.black)
                    .bold()
                Spacer()
                Text("View all")
                    .foregroundColor(.gray)
            }.padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    if rightData {
                        ForEach(viewModel.dataLatest) { post in
                            LatestComponentView(backgroundImage: post.imageUrl, price: String(post.price), productName: post.name, category: post.category)
                        }
                    }
                }.padding(.horizontal)
            }
            
        }
        
    }
    
    var flashSaleView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Flash sale")
                    .foregroundColor(.black)
                    .bold()
                Spacer()
                Text("View all")
                    .foregroundColor(.gray)
            }.padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    if rightData {
                        ForEach(viewModel.dataFlash) { post in
                            FlashsaleComponentView(backgroundImage: URL(string: post.imageUrl)! , price: String(post.price ?? 0.0), productName: post.name, category: post.category, discount: String(post.discount))
                                .onTapGesture {
                                    showAdd.toggle()
                                }
                        }
                    }
                }.padding(.horizontal)
            }
            
        }
    }
    
    var brandsView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Brands")
                    .foregroundColor(.black)
                    .bold()
                Spacer()
                Text("View all")
                    .foregroundColor(.gray)
            }.padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    if rightData {
                        ForEach(viewModel.dataLatest) { post in
                            LatestComponentView(backgroundImage: post.imageUrl, price: String(post.price), productName: post.name, category: post.category)
                        }
                    }
                }.padding(.horizontal)
            }
            
        }
        
    }
}

struct Page1_Previews: PreviewProvider {
    static var previews: some View {
        Page1()
    }
}
