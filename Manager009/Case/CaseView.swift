//
//  CaseView.swift
//  Manager009
//
//  Created by bernard milman on 1/8/26.
//

import SwiftUI
import Foundation
import UniformTypeIdentifiers


struct CaseTrans: Codable, Transferable  {
        static var transferRepresentation: some TransferRepresentation {
            CodableRepresentation(contentType: .data)
        }
        
        var caseId: Int
        var procNickname: String
    }

struct CaseView: View {
   
    var caseTotal: CaseModel
    
    var body: some View {
       
        let transCase: CaseTrans = CaseTrans(caseId: caseTotal.id, procNickname: caseTotal.procedureNickName)
            
        Text("\(transCase.caseId) - \(transCase.procNickname)")
            .font(Font.largeTitle)
            .draggable(transCase)
    }
}

//#Preview {
//    CaseView()
//}

