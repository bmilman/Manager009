//
//  CreateLocationTab.swift
//  Manager009
//
//  Created by bernard milman on 1/6/26.
//

import SwiftUI
import SwiftData

struct CreateLocationTab: View {
    
    @Query private var locations: [Location]
    @Environment(\.modelContext) private var modelContext
    @State private var path = [Location] ()

    func addLocation() {
        let loc = Location(locationName: "sasas")
        modelContext.insert(loc)
        do {
            try modelContext.save()
        } catch {
            print("Failed to save: \(error)")
        }
        path.append(loc)
    }
    func deleteLocation(at offsets: IndexSet) {
      for index in offsets {
            let loc = locations[index]
            modelContext.delete(loc)
        }
     }

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(locations) { loc in
                    NavigationLink(value: loc) {
                        Text(loc.locationName )
                    }
                }
                .onDelete(perform: deleteLocation)
            }
            .navigationDestination(for: Location.self) { loc in
                EditLocationView(location:loc)
            }
            .navigationTitle("number of records in locations: \(locations.count) ")

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Location", systemImage: "plus") {
                        addLocation()                    }
                }
            }

          
        }
    }
}

#Preview {
    CreateLocationTab()
}
