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

    private var transPerson: Encodable {
        struct TransferPerson: Encodable {
            let nickName: String
            let personId: Int
        }
        return TransferPerson(nickName: person.nickName, personId: person.personId)
    }

    private var draggableJSON: String {
        (try? encodeToJSONString(transPerson)) ?? ""
    }
    
    
    var body: some View {
        
        VStack{
            Label(person.nickName, systemImage: "person")
           // Text("ID \(transPerson.personID)")
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

