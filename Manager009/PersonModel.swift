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
    var details: String

    init(firstName: String, lastName: String, details: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.details = details
    }
    
}
