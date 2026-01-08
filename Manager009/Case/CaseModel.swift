//
//  CaseModel.swift
//  Manager009
//
//  Created by bernard milman on 1/8/26.
//

import Foundation
import SwiftData

@Model class CaseModel: Identifiable {
    var id: Int = Int.random(in: 1...1000000000)
    var patientFirstName: String
    var patientLastName: String
    var patientMRN: Int
    var procedureName: String
    var procedureNickName: String
    var proceduerStart: Date? = nil
    var proceduerEnd: Date? = nil
    
    init( patientFirstName: String, patientLastName: String, patientMRN: Int, procedureName: String, procedureNickName: String) {
        //self.id = id
        self.patientFirstName = patientFirstName
        self.patientLastName = patientLastName
        self.patientMRN = patientMRN
        self.procedureName = procedureName
        self.procedureNickName = procedureNickName
       // self.proceduerStart = proceduerStart
        //self.proceduerEnd = proceduerEnd
    }
}
    
    
