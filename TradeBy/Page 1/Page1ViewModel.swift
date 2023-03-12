import SwiftUI
import Combine

enum DataType {
    case latest, flashSale, words, additional
}

class NetworkViewModel: ObservableObject {
    
    @Published var dataLatest: [LatestProduct] = []
    @Published var dataFlash: [FlashSaleProduct] = []
    @Published var dataWords: [String] = []
    @Published var dataAdditional: Shoe = Shoe(name: "", description: "", rating: 0.0, numberOfReviews: 0, price: 0, colors: [], imageUrls: [])
    var dataType: DataType = .flashSale
    
    private var cancellable: AnyCancellable?
    
    func fetchData(dataType: DataType) {
        let url: String
        switch dataType {
        case .latest:
            url = "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
        case .flashSale:
            url = "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
        case .words:
            url = "https://run.mocky.io/v3/4c9cd822-9479-4509-803d-63197e5a9e19"
        case .additional:
            url = "https://run.mocky.io/v3/f7f99d04-4971-45d5-92e0-70333383c239"
        }
        
        
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        switch dataType {
            
        case .latest:
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: LatestResponse.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }, receiveValue: { response in
                    DispatchQueue.main.async {
                        self.dataLatest = response.latest
                    }
                    
                })
        case .flashSale:
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: FlashSaleResponse.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { response in
                    DispatchQueue.main.async {
                        self.dataFlash = response.flash_sale
                    }
                })
        case .words:
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: WordsResponse.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { response in
                    DispatchQueue.main.async {
                        self.dataWords = response.words
                    }
                })
        case .additional:
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: Shoe.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { response in
                    DispatchQueue.main.async {
                        self.dataAdditional = response
                    }
                })
        }
        
    }
}


