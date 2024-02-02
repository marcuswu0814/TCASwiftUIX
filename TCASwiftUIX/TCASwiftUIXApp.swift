//
//  TCASwiftUIXApp.swift
//  TCASwiftUIX
//
//  Created by Marcus Wu on 2024/2/2.
//

import SwiftUI

@main
struct TCASwiftUIXApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView(store: .init(initialState: .init()) {
                    Feature()
                })
                .tabItem { Text("✅") }
                
                WrongContentView(store: .init(initialState: .init()) {
                    Feature()
                })
                .tabItem { Text("⚠️") }
            }
        }
    }
}
