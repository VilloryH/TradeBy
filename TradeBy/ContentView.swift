import SwiftUI

struct ContentView: View {
    @EnvironmentObject var envModel: EnvironmentClass
    @AppStorage("selectedTab") var selectedTab: Tab = .profile
    var body: some View {
        ZStack(alignment: .bottom) {
                   switch selectedTab {
                   case .home:
                       Page1()
                   case .liked:
                       Text("LIKED")
                   case .cart:
                       Text("Cart")
                   case .chat:
                       Text("Chat")
                   case .profile:
                      ProfileView()
                   }
                 TabBar()
                      
               }.safeAreaInset(edge: .bottom){
                   Color.clear.frame(height: 44)}
           }
              
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
