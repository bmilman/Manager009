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
    @State private var personsArray: [PersonTransferable] = []
    
    
    var body: some View {
        HStack {
            
            VStack{
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 400)
                    .frame(maxHeight: 200)
                    .dropDestination(for: String.self) { items, location in
                        let decoder = JSONDecoder()
                        var decodedAny = false
                        for item in items {
                            if let data = item.data(using: .utf8),
                               var personTransferable = try? decoder.decode(PersonTransferable.self, from: data) {
                                personTransferable.location = location
                                personsArray.append(personTransferable)
                                print("Dropped PersonTransferable => nickname: \(personTransferable.nickname), id: \(personTransferable.personID), location: \(location)")
                                decodedAny = true
                            } else {
                                print("Failed to decode dropped item as PersonTransferable JSON: \(item)")
                            }
                        }
                        return decodedAny
                    }
                
                ForEach(Array(personsArray.enumerated()), id: \.offset) { index, item in
                    Text(item.nickname)
                        .font(.caption)
                        .padding(4)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(4)
                        .position(x: item.location.x, y: item.location.y)
                }
            }
                VStack {
                    ForEach(personsArray, id: \.personID) { person in
                        Label(person.nickname, systemImage: "person")
                    }
                }        }
            VStack {
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
                .background(Color.green)

                VStack {
                    ForEach(people) { person in
                        PersonTransferableView(person: person)
                    }
                }
                
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

