//
//  Liason_Location_Case.swift
//  Manager009
//
//  Created by bernard milman on 1/9/26.
//

import Foundation
import SwiftData

@Model class Liason_Location_Case: Identifiable {
    var id: Int = Int.random(in: 1...1000000000)
    var locationId: Int
    var locationName: String
    var caseId: Int
    var procNickname: String
    var procedureStart: Date
    var procedureEnd: Date
    
    init(locationId: Int, locationName: String, caseId: Int, procNickname: String, procedureStart: Date, procedureEnd: Date) {
        self.locationId = locationId
        self.locationName = locationName
        self.caseId = caseId
        self.procNickname = procNickname
        self.procedureStart = procedureStart
        self.procedureEnd = procedureEnd
    }
    
}
