//
//  EditPersonView.swift
//  Manager009
//
//  Created by bernard milman on 1/3/26.
//

import SwiftUI

struct EditPersonView: View {
    
    @Bindable var person: Person
    
    var body: some View {
        
        Form {
            Section(header: Text("Personal Information")) {
                TextField("First Name", text: $person.firstName)
                TextField("Last Name", text: $person.lastName)
            }
            .textContentType(.name)
            .textInputAutocapitalization(.words)
            
//            Section ("Notes"){
//                TextField("Person ID", value: $person.personId, format: .number)
//                    .keyboardType(.numberPad)
//            }
        }
        .navigationTitle(Text("Edit Person"))
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

//#Preview {
//    EditPersonView()
//}

