//
//  PersonModel.swift
//  Manager009
//
//  Created by bernard milman on 1/3/26.
//

import Foundation
import SwiftData

@Model class Person {
    var firstName: String
    var lastName: String
    var personId: Int
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.personId = Int(Date().timeIntervalSince1970 * 1000)
    }
    
    var nickName: String {
        "\(firstName) \(lastName)"
    }
    
    
//    var transPerson: PersonTransferable {
//        PersonTransferable(nickname: "\(firstName) \(lastName)", personID: personId)
//    }
    
    
    
}


