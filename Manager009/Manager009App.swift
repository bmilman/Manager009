//
//  Manager009App.swift
//  Manager009
//
//  Created by bernard milman on 1/3/26.
//

import SwiftUI
import SwiftData

@main
struct Manager009App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Person.self, Location.self, Liason_Location_Person.self])
        }
    }
}
