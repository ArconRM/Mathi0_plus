//
//  Mathi0_App.swift
//  Mathi0+ WatchKit Extension
//
//  Created by Artemiy Mirotvortsev on 06.02.2022.
//

import SwiftUI

@main
struct Mathi0_App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
