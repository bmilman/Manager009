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
    
    //SCTOLL VIEWS
    @State private var startDate: Date = Date(timeIntervalSinceNow: -1000)
    @State private var endDate: Date = Date(timeIntervalSinceNow: +86400)
    @State private var scrollPosition: ScrollPosition = .init(x: 50)
    
    
    //RIGHT VIEW
    @State private var isRightViewVisible = true
    private let rightViewWidth: CGFloat = 320
    
    
    
    
    var body: some View {
        
       
        
        
        HStack {
            
            ZStack{
                ScrollView(.horizontal) {
                    ZStack {
                        TimeLinePlainView(start: startDate , end: endDate)
                        
                        VStack {
                            ForEach(locations) { location in
                                LocationRowView( location: location, startTime: startDate,endTime: endDate, scrollPosition: $scrollPosition )
                            }
                        }
//                        .onChange(of: scrollPosition) { old, new in
//                            print("scrollPosition changed from \(old) to \(new)")
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .scrollPosition($scrollPosition)
            }
            .frame(maxWidth: .infinity) // allow full expansion
            
            
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
            
            .frame(width: isRightViewVisible ? rightViewWidth : 0) // collapses layout space
            .clipped()
            .offset(x: isRightViewVisible ? 0 : rightViewWidth + 12)
            .animation(.easeInOut(duration: 0.25), value: isRightViewVisible)
        }
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation(.easeInOut) { isRightViewVisible.toggle() }
            } label: {
                Image(systemName:  "sidebar.right" )
                    .padding(8)
                    .background(.ultraThinMaterial, in: Capsule())
            }
            .padding()
        }
        
    }
        
}

