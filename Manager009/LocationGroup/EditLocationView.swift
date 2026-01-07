//
//  EditLocationView.swift
//  Manager009
//
//  Created by bernard milman on 1/6/26.
//

import SwiftUI

struct EditLocationView: View {
    
    @Bindable var location: Location
    
    
    var body: some View {
        Form {
            Section(header: Text("Location")) {
                TextField("Name", text: $location.locationName)
            }
        }
        .navigationTitle(Text("Edit Location"))
    }
}

//#Preview {
//    EditLocationView()
//}
