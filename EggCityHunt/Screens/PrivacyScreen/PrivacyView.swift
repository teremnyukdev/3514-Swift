import SwiftUI

struct PrivacyView: View {
        
    @AppStorage("firstOpenApp") var firstOpenApp = true
    @AppStorage("stringURL") var stringURL = ""

    @EnvironmentObject var appState: AppState
    @State private var isContentLoaded = false
    
    var screenType: TypeScreen = .policy

    var body: some View {
        VStack {
            if isContentLoaded && stringURL.isEmpty {
                ScrollView(showsIndicators: true) {
                    Text(screenType.description)
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                }
                actionButtons
            } else {
                WebViewContainer(stringURL: stringURL) {
                    isContentLoaded = true
                }
                .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
                .ignoresSafeArea(.keyboard)
                .hideNavigationBar()
                .background(
                    LinearGradient(
                        gradient: .init(
                            colors: !stringURL.isEmpty ? [Color.black] : [
                                .privacyGradientTop,
                                .privacyGradientBottom
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .background(
            LinearGradient(
                gradient: .init(
                    colors: !stringURL.isEmpty ? [Color.black] : [
                        .privacyGradientTop,
                        .privacyGradientBottom
                    ]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .onChange(of: stringURL) { newValue in
            if stringURL == "error" {
                appState.goHome()
            }
        }
        .hideNavigationBar()
        .onAppear {
            // Allow both portrait and landscape while the privacy screen is visible.
            // Avoid forcing device orientation values (UIDevice.setValue) because that can
            // create snapshot/presentation artifacts (a small leftover of the previous view).
            AppDelegate.orientationLock = [.portrait, .landscapeLeft, .landscapeRight]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                UIViewController.attemptRotationToDeviceOrientation()
            }
        }
        .onDisappear {
            AppDelegate.orientationLock = .portrait
        }
    }
}

extension PrivacyView {
    var actionButtons: some View {
        HStack {
            Button {
                firstOpenApp = false
                appState.goHome()
            } label: {
                Text("Agree".uppercased())
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.strokeGreen)
                            
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.strokeGreen, lineWidth: 3)
                        }
                    )
            }
            Spacer()
            Button {
                firstOpenApp = false
                exit(0)
            } label: {
                Text("Reject".uppercased())
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.red)
                            
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.red, lineWidth: 3)
                        }
                    )
            }
        }
        .padding(.horizontal, 30)
        .foregroundStyle(.white)
        .font(.caption2)
    }
}

#Preview {
    PrivacyView()
        .environmentObject(AppState())
}
