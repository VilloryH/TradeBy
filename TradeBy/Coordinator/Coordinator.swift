import SwiftUI

enum Page: String, Identifiable {
    case login, signIn, profile, content
    
    var id: String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    case login
    
    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {
    case login, signIn, page1, content
    
    var id: String {
        self.rawValue
    }
}


class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreen: FullScreenCover?
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func present(fullScreen: FullScreenCover) {
        self.fullScreen = fullScreen
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullscreenCover() {
        self.fullScreen = nil
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .login:
            LoginView()
        case .signIn:
            SignInView()
        case .profile:
            ProfileView()
        case .content:
            ContentView()
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .login:
            LoginView()
        }
    }
    
    @ViewBuilder
    func build(fullScreen: FullScreenCover) -> some View {
        switch fullScreen {
        case .login:
            LoginView()
        case .signIn:
            SignInView()
        case .page1:
            Page1()
        case .content:
            ContentView()
        }
    }
}

