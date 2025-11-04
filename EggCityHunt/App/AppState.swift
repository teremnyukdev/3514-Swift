//
//  AppState.swift
//  EggCityHunt
//
//  Created by Protsak Dmytro on 04.11.2025.
//

import Foundation
import Foundation
import SwiftUI

final class AppState: ObservableObject {
    enum Route {
        case launch
        case privacy
        case home
    }

    @Published var route: Route

    init() {
        let stringURL = UserDefaults.standard.string(forKey: "stringURL") ?? ""
        let firstOpenApp = UserDefaults.standard.bool(forKey: "firstOpenApp")

        if !stringURL.isEmpty || firstOpenApp {
            route = .privacy
            AppDelegate.orientationLock = [.portrait, .landscapeLeft, .landscapeRight]
        } else {
            route = .launch
            AppDelegate.orientationLock = .portrait
        }
    }

    func goHome() {
        AppDelegate.orientationLock = .portrait
        route = .home
    }

    func goPrivacy() {
        AppDelegate.orientationLock = [.portrait, .landscapeLeft, .landscapeRight]
        route = .privacy
    }

    func goLaunch() {
        AppDelegate.orientationLock = .portrait
        route = .launch
    }
}
