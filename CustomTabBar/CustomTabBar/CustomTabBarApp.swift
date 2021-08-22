//
//  CustomTabBarApp.swift
//  CustomTabBar
//
//  Created by brown on 2021/08/21.
//

import SwiftUI

@main
struct CustomTabBarApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewRouter())
        }
    }
}
