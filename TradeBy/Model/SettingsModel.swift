import Foundation


struct SettingsModel: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let arrow: Bool
    let text: String?
}

var settings = [
SettingsModel(name: "Trade store", image: "creditcard", arrow: true, text: nil),
SettingsModel(name: "Payment method", image: "creditcard", arrow: true, text: nil),
SettingsModel(name: "Balance", image: "creditcard", arrow: false, text: "$ 1593"),
SettingsModel(name: "Trade history", image: "creditcard", arrow: true, text: nil),
SettingsModel(name: "Restore Purchase", image: "arrow.triangle.2.circlepath", arrow: true, text: nil),
SettingsModel(name: "Help", image: "questionmark.circle", arrow: false, text: nil),
SettingsModel(name: "Log out", image: "rectangle.portrait.and.arrow.right", arrow: false, text: nil),
]
