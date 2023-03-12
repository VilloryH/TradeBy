import Foundation

enum Categories {
    case phone
    case headphones
    case games
    case cars
    case furnitures
    case kids
}

struct CategoryModel: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var category: Categories
}

var categories = [
    CategoryModel(name: "Phones", image: "iphone", category: .phone),
    CategoryModel(name: "Headphones", image: "headphones", category: .headphones),
    CategoryModel(name: "Games", image: "gamecontroller.fill", category: .games),
    CategoryModel(name: "Cars", image: "car.fill", category: .cars),
    CategoryModel(name: "Furnitures", image: "bed.double.fill", category: .furnitures),
    CategoryModel(name: "Kids", image: "face.smiling.inverse", category: .kids)
]
