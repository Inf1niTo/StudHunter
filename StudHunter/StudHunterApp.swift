//
//  StudHunterApp.swift
//  StudHunter
//
//  Created by Антон Сетямин on 16.02.2023.
//

import SwiftUI
import FirebaseCore

@main
struct StudHunterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var shopVM: ShopViewModel = ShopViewModel()
    var body: some Scene {
        WindowGroup {
            StudHunterView()
                .environmentObject(shopVM)
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
