//
//  Liason_Location_Person.swift
//  Manager009
//
//  Created by bernard milman on 1/7/26.
//

import Foundation
import SwiftData

@Model class Liason_Location_Person: Identifiable {
    var id: UUID
    var locationName: String
    var locationId: Int
    var personNickName: String
    var personId: Int
    var createdAt: Date
    
    init(id: UUID, locationName: String, locationId: Int, personNickName: String, personId: Int, createdAt: Date) {
        self.id = id
        self.locationName = locationName
        self.locationId = locationId
        self.personNickName = personNickName
        self.personId = personId
        self.createdAt = createdAt
    }
    
    
}
