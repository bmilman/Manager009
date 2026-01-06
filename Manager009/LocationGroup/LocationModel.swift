//
//  LocationModel.swift
//  Manager009
//
//  Created by bernard milman on 1/5/26.
//

import Foundation
import SwiftData

@Model class Location: Identifiable, Hashable {
    var locationID: Int
    var locationName: String
    
    init(locationID: Int, locationName: String) {
        self.locationID = Int.random(in: 1...1000)
        self.locationName = locationName
    }
}

