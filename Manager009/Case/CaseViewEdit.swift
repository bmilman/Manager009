//
//  CaseViewEdit.swift
//  Manager009
//
//  Created by bernard milman on 1/8/26.
//

import SwiftUI

struct CaseViewEdit: View {
    
    @Bindable var selectedCase: CaseModel
    
    var body: some View {
        Form {
            Section(header: Text("Case Details")) {
                TextField("First Name", text: $selectedCase.patientFirstName)
                TextField("Last Name", text: $selectedCase.patientLastName)
                TextField("MRN", value: $selectedCase.patientMRN, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                TextField("Procedure Full Name", text: $selectedCase.procedureName)
                TextField("Procedure Short", text: $selectedCase.procedureNickName)
                DatePicker("Start Date", selection: Binding(
                    get: { selectedCase.proceduerStart ?? Date() },
                    set: { selectedCase.proceduerStart = $0 }
                ), displayedComponents: .date)
                DatePicker("End Date", selection: Binding(
                    get: { selectedCase.proceduerEnd ?? Date() },
                    set: { selectedCase.proceduerEnd = $0 }
                ), displayedComponents: .date)            
            }
        }
        .navigationTitle(Text("Edit Case"))
    }
}

//#Preview {
//    CaseViewEdit()
//}

