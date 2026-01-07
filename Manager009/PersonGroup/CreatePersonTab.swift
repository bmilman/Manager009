//
//  CreatePersonTab.swift
//  Manager009
//
//  Created by bernard milman on 1/5/26.
//
import SwiftUI
import SwiftData



  struct CreatePersonTab: View {
        
        @Query private var people: [Person]
        @Environment(\.modelContext) private var modelContext
        @State private var path = [Person] ()

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
        }
        
        
        var body: some View {
            NavigationStack(path: $path) {
                List {
                    ForEach(people) { person in
                        NavigationLink(value: person) {
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
            //.background(Color.green)
        }
    }
