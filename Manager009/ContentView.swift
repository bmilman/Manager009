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
        }
    }
    
    
    
    struct Person_Location_Tab: View {
        
        @Query var people: [Person]
        //@State private var personsArray: [PersonTransferable] = []
        
        var body: some View {
            HStack {
                VStack {
                    ZStack(alignment: .topLeading) {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 400)
                            .frame(maxHeight: 200)
                            .dropDestination(for: String.self) { items, location in
                                //                                let decoder = JSONDecoder()
                                //                                var decodedAny = false
                                //                                for item in items {
                                //                                    if let data = item.data(using: .utf8),
                                //                                       var personTransferable = try? decoder.decode(PersonTransferable.self, from: data) {
                                //                                        personTransferable.location = location
                                //                                        personsArray.append(personTransferable)
                                //                                        decodedAny = true
                                //                                    } else {
                                //                                        print("Failed to decode dropped item as PersonTransferable JSON: \(item)")
                                //                                    }
                                //                                }
                                return //decodedAny
                            }
                        
                        //                        ForEach(Array(personsArray.enumerated()), id: \.offset) { _, item in
                        //                            Text(item.nickname)
                        //                                .font(.caption)
                        //                                .padding(4)
                        //                                .background(Color.white.opacity(0.8))
                        //                                .cornerRadius(4)
                        //                                .position(x: item.location.x, y: item.location.y)
                        //                        }
                    }
                }
                //                .onAppear {
                //                    if personsArray.isEmpty {
                //                        personsArray = people.map { person in
                //                            PersonTransferable(nickname: person.firstName, personID: person.personId, location: .zero)
                //                        }
                //                    }
                //                }
                
                List {
                     ForEach(people) { person in
                         PersonTransferableView(person: person)
                     }
                 }            }
        }
    }

  
}

#Preview {
    ContentView()
}

