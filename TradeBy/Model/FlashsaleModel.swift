import Foundation

struct FlashSaleResponse: Codable {
    let flash_sale: [FlashSaleProduct]
}

struct FlashSaleProduct: Codable, Identifiable {
    let id = UUID()
    let category: String
    let name: String
    let price: Double?
    let discount: Int
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case category, name, price, discount
        case imageUrl = "image_url"
    }
}

