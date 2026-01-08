//
//  Person_Location_View.swift
//  Manager009
//
//  Created by bernard milman on 1/7/26.
//

import SwiftUI
import SwiftData

struct Person_Location_Tab: View {
    
    @Query var people: [Person]
    @Query var locations: [Location]
    @Query var cases: [CaseModel]
    //@State private var personsArray: [PersonTransferable] = []
    
    var body: some View {
        HStack {
            
            VStack {
                ForEach(locations) { location in
                    LocationRowView(location: location)
                }
            }
            //.allowsHitTesting(true)
            VStack{
                List {
                    ForEach(people) { person in
                        PersonTransferableView(person: person)
                    }
                }
                List {
                    ForEach(cases) { caseModel in
                        CaseView(caseTotal:caseModel)
                    }
                }
            }
        }
    }
}

