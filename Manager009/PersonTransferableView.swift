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
    
    private struct PersonSummary: Codable {
        let firstName: String
        let lastName: String
        let details: String
    }

    private var draggableJSON: String {
        let summary = PersonSummary(firstName: person.firstName, lastName: person.lastName, details: person.details)
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(summary), let json = String(data: data, encoding: .utf8) else {
            return ""
        }
        return json
    }
    
    
    var body: some View {
        
        VStack{
            Text("first name \(person.firstName)")
            Text("last name \(person.lastName)")
            Text("details \(person.details)")
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

