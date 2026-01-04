//
//  ContentView.swift
//  Manager009
//
//  Created by bernard milman on 1/3/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var people: [Person]
    @Environment(\.modelContext) var modelContext
    @State private var path = [Person] ()
    
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color.blue)
                .frame(width: 200) // fixed width
                .frame(maxHeight: .infinity) // take available vertical space
            
                .dropDestination(for: String.self) { items, location in
                    struct PersonSummary: Codable {
                        let firstName: String
                        let lastName: String
                        let personId: Int
                    }

                    let decoder = JSONDecoder()
                    var decodedAny = false
                    for item in items {
                        if let data = item.data(using: .utf8),
                           let summary = try? decoder.decode(PersonSummary.self, from: data) {
                            print("Dropped person => first: \(summary.firstName), last: \(summary.lastName), details: \(summary.personId), location: \(location)")
                            decodedAny = true
                        } else {
                            print("Failed to decode dropped item as PersonSummary JSON: \(item)")
                        }
                    }
                    return decodedAny
                }
            

            
        VStack{
            NavigationStack  ( path:$path){
                List{
                    ForEach( people ) { person in
                        NavigationLink (value: person) {
                            Text(person.firstName + " " + person.lastName)
                        }
                    }
                }
                
                .navigationDestination(for: Person.self) { person in
                    EditPersonView(person: person)
                }
                
                .navigationTitle("Edit Person")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add Person", systemImage: "plus") {
                            addPerson()
                        }
                    }
                }
            }
            .background(Color.green)
            
            
            VStack{
                ForEach(people){ person in
                    PersonTransferableView(person: person)
                        
                }
            }
            //.background(Color.orange)
            //.padding(10)
            
        }
    }
    }
    
    func addPerson() {
        let person = Person(firstName: "ewt", lastName: "tewt")
        
        modelContext.insert(person)
        do {
            try modelContext.save()
        } catch {
            print("Failed to save: \(error)")
        }

        path.append(person)
        print ("number of records in path: \(path.count) ")
        print ("number of records in array: \(people.count) ")
    }
}

#Preview {
    ContentView()
}

