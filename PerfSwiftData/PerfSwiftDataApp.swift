//
//  PerfSwiftDataApp.swift
//  PerfSwiftData
//
//  Created by Uhl Albert on 8/19/24.
//

import SwiftUI
import SwiftData

@main
struct PerfSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
