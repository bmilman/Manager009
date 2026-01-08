//
//  CaseViewCreation.swift
//  Manager009
//
//  Created by bernard milman on 1/8/26.
//

import SwiftUI
import SwiftData

struct CaseViewCreation: View {
    
    @Query private var cases: [CaseModel]
    @Environment(\.modelContext) private var modelContext
    @State private var path = [CaseModel] ()
    
    func addCase() {
        let cas = CaseModel ( patientFirstName: "", patientLastName: "", patientMRN: 0, procedureName: "", procedureNickName: "")
        modelContext.insert(cas)
        do {
            try modelContext.save()
        } catch {
            print("Failed to save: \(error)")
        }
        path.append(cas)
    }
    
    func deleteCase(at offsets: IndexSet) {
        for index in offsets {
            let cas = cases[index]
            modelContext.delete(cas)
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(cases) { cas in
                    NavigationLink(value: cas) {
                        Text(cas.procedureName )
                    }
                }
                .onDelete(perform: deleteCase)
            }
            .navigationDestination(for: CaseModel.self) { cas in
                CaseViewEdit(selectedCase: cas)
            }
            .navigationTitle("CASES")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Case", systemImage: "plus") {
                        addCase()                    }
                }
            }
            
            
        }
    }
}
    
    //#Preview {
//    CaseViewCreation()
//}
