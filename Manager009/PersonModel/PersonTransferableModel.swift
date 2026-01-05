//
//  PersonTransferableModel.swift
//  Manager009
//
//  Created by bernard milman on 1/5/26.
//

import Foundation
import CoreGraphics


struct PersonTransferable: Codable {
    var nickname: String
    var personID: Int
    var location: CGPoint = .zero
}
