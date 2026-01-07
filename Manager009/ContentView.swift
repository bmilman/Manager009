//
//  ContentView.swift
//  Manager009
//
//  Created by bernard milman on 1/3/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
   // @Environment(\.modelContext) var modelContext
    
    var body: some View {
        TabView {
            Person_Location_Tab()
                .tabItem { Label("Person-Location", systemImage: "square.on.square") }
            
            CreatePersonTab()
                .tabItem { Label("People", systemImage: "person.2") }
            
            CreateLocationTab()
                .tabItem { Label("Locations", systemImage: "l.joystick.tilt.left.fill")}
        }
    }
    
    
    
}

#Preview {
    ContentView()
}

