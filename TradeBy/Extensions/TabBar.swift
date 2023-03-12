import SwiftUI

struct TabBar: View {
    
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    private let tabItemWidth: CGFloat = 12
    var body: some View {
        HStack {
            buttons
        }
        .padding(.horizontal, 20)
        .padding(.top, 14)
        .frame(height: 88, alignment: .top)
        .background (.white, in: RoundedRectangle(cornerRadius: 34, style: .continuous))
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    selectedTab = item.tab
                }
            }) {
                VStack(spacing: 0) {
                    Circle()
                        .fill(selectedTab == item.tab ? .gray.opacity(0.5) : .clear)
                        .frame(width: 40, height: 40)
                        .overlay(
                    Image(systemName: item.icon)
                        .symbolVariant(.fill)
                        .font(.body.bold())
                        .frame(width: 44, height: 29)
                        .mask(Circle()
                            .frame(width: 40, height: 40))
                        )
                }
                .frame(maxWidth: .infinity)
            }
            .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)

        }
    }

}


