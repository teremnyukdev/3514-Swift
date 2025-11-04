//
//  EggCityHuntApp.swift
//  EggCityHunt
//
//  Created by Serhii Babchuk on 24.10.2025.
//

import SwiftUI

@main
struct EggCityHuntApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            AppEntryPoint()
                .environmentObject(appState)
        }
    }
}
