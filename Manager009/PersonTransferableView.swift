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
        person.transPerson
    }

    private var draggableJSON: String {
        (try? encodeToJSONString(transPerson)) ?? ""
    }
    
    
    var body: some View {
        
        VStack{
            Label(transPerson.nickname, systemImage: "person")
            Text("ID \(transPerson.personID)")
        }
        .border(Color.black)
        .draggable(draggableJSON)
    }
}

//#Preview {
//    PersonTransferableView()
//}

//func makeJSONstring(from value: PersonTransferable) throws -> String {
//    try encodeToJSONString(value)
//}

