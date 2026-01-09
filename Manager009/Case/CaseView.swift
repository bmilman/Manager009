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
    static let caseContentType = UTType(exportedAs: "com.manager009.casetrans")

    static var transferRepresentation: some TransferRepresentation {
            CodableRepresentation(contentType: caseContentType)
        }
        
        var caseId: Int
        var procNickname: String
        var procedureStart: Date
        var procedureEnd: Date
    }

struct CaseView: View {
   
    var caseTotal: CaseModel
    
    var body: some View {
       
        let transCase: CaseTrans = CaseTrans(caseId: caseTotal.id, procNickname: caseTotal.procedureNickName, procedureStart: caseTotal.proceduerStart ?? .now, procedureEnd: caseTotal.proceduerEnd ?? .distantFuture)
            
        Text("\(transCase.caseId) - \(transCase.procNickname)")
            .font(Font.largeTitle)
            .draggable(transCase)
    }
}

//#Preview {
//    CaseView()
//}

