import Foundation

struct Shoe: Codable, Identifiable  {
    var id = UUID()
    let name: String
    let description: String
    let rating: Double
    let numberOfReviews: Int
    let price: Int
    let colors: [String]
    let imageUrls: [URL]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case rating
        case numberOfReviews = "number_of_reviews"
        case price
        case colors
        case imageUrls = "image_urls"
    }
}
