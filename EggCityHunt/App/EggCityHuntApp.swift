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
    
    var body: some Scene {
        WindowGroup {
            AppEntryPoint()
        }
    }
}
