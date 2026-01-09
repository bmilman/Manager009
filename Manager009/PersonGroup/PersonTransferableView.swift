//
//  PersonTransferableView.swift
//  Manager009
//
//  Created by bernard milman on 1/3/26.
//

import SwiftUI
import Foundation
import UniformTypeIdentifiers


struct PersonTrans: Codable, Transferable  {
    static let personContentType = UTType(exportedAs: "com.manager009.personTrans")
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: personContentType)
    }
    var nickName: String
    var personId: Int
}



struct PersonTransferableView: View {
    
    var person: Person
    
    var body: some View {
        
        let transPerson = PersonTrans(nickName: person.nickName, personId: person.personId)
        
        Text("\(person.nickName)")
            .font(Font.largeTitle)
            .draggable(transPerson)
    }
}

//#Preview {
//    PersonTransferableView()
//}

//func makeJSONstring(from value: PersonTransferable) throws -> String {
//    try encodeToJSONString(value)
//}

