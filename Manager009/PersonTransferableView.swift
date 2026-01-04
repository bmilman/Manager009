//
//  PersonTransferableView.swift
//  Manager009
//
//  Created by bernard milman on 1/3/26.
//

import SwiftUI

struct PersonTransferableView: View {
    
    var person: Person
    
    
    
    var body: some View {
        
        VStack{
            Text("first name\(person.firstName)")
                .padding(2)
            Text("last name\(person.lastName)")
                .padding(2)
            Text("details\(person.details)")
        }
        
        //.draggable(person.firstName)
    }
}

//#Preview {
//    PersonTransferableView()
//}

