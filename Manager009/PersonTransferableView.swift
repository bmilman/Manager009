//
//  PersonTransferableView.swift
//  Manager009
//
//  Created by bernard milman on 1/3/26.
//

import SwiftUI
import Foundation

struct PersonTransferableView: View {
    
    var person: Person
    private var transPerson: PersonTransferable {
        PersonTransferable(
            nickname: person.firstName + " " + person.lastName,
            personID: person.personId,
            location: .zero
        )
    }

//    private struct PersonSummary: Codable {
//        let firstName: String
//        let lastName: String
//        let personId: Int
//    }

    private var draggableJSON: String {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(transPerson),
              let json = String(data: data, encoding: .utf8) else {
            return ""
        }
        return json
    }
    
    
    var body: some View {
        
        VStack{
            Text("Name:\(transPerson.nickname)")
            Text("ID \(transPerson.personID)")
        }
        .border(Color.black)
        .draggable(draggableJSON)
        //.draggable(person.lastName)
        //.draggable(person.details)
    }
}

//#Preview {
//    PersonTransferableView()
//}

