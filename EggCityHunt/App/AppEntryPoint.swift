import SwiftUI

struct AppEntryPoint: View {
    @AppStorage("stringURL") var stringURL = ""
    @AppStorage("firstOpenApp") var firstOpenApp = true

    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            Group {
                switch appState.route {
                case .privacy:
                    PrivacyView()
                case .launch:
                    ECLaunchView()
                case .home:
                    ECHomeWebView()
                }
            }
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3), value: appState.route)
        }
        .onAppear(perform: {
            // AppState already configured initial route in its init; nothing else required here
        })
    }
}
