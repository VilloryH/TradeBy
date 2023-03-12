import Foundation
import SwiftUI

struct TabItem: Identifiable{
    var id = UUID()
    var icon:String
    var tab:Tab
}

var tabItems = [
    TabItem(icon: "house",tab: .home),
    TabItem(icon: "heart", tab: .liked),
    TabItem(icon: "cart",tab: .cart),
    TabItem(icon: "bubble.left", tab: .chat),
    TabItem(icon: "person", tab: .profile)
    
]

enum Tab:String { 
    case home
    case liked
    case cart
    case chat
    case profile
}

struct TabPreferenceKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
