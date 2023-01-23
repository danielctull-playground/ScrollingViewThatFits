
import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollingViewThatFits {
            LongContent()
        } header: {
            Color.purple
                .frame(height: 50)
                .frame(maxWidth: .infinity)
        } footer: {
            Color.yellow
                .frame(height: 100)
                .frame(maxWidth: .infinity)
        }
    }
}

struct ScrollingViewThatFits<Content: View, Header: View, Footer: View>: View {
    let content: Content
    let header: Header
    let footer: Footer

    init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header,
        @ViewBuilder footer: () -> Footer
    ) {
        self.content = content()
        self.header = header()
        self.footer = footer()
    }

    var notScrolling: some View {
        VStack {
            header
            Spacer(minLength: 0)
            content
            Spacer(minLength: 0)
            footer
        }
    }

    var scrolling: some View {
        ScrollView {
            header.hidden()
            content
            footer.hidden()
        }
        .overlay {
            VStack {
                header
                Spacer(minLength: 0)
                footer
            }
        }
    }

    var body: some View {
        ViewThatFits(in: .vertical) {
            notScrolling
            scrolling
        }
    }
}

struct LongContent: View {

    var body: some View {
        VStack {
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            Button {
            } label: {
                Text("Hello")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
