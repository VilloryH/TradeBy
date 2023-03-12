import Foundation

struct LatestResponse: Codable {
    let latest: [LatestProduct]
}

struct LatestProduct: Codable, Identifiable {
    var id = UUID()
    let category: String
    let name: String
    let price: Int
    let imageUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case category, name, price
        case imageUrl = "image_url"
    }
}
