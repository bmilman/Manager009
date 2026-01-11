//
//  LocationRowView.swift
//  Manager009
//
//  Created by bernard milman on 1/6/26.
//

import SwiftUI
import SwiftData

struct LocationRowView: View {
    
    @Query private var liasonPerson: [Liason_Location_Person]
    @Query private var liasonCase: [Liason_Location_Case]
    @Environment(\.modelContext) private var modelContext

    var location: Location
    var startTime: Date
    var endTime: Date
    @Binding var scrollPosition: ScrollPosition
    //@State private var scrollPosition: ScrollPosition = .init(x: 50)
    
    init(location: Location, startTime: Date, endTime: Date, scrollPosition: Binding<ScrollPosition>) {
        self.location = location
        let targetLocationID = location.locationID
        _liasonPerson = Query(
            filter: #Predicate<Liason_Location_Person> { item in
                item.locationId == targetLocationID
            },
            sort: [SortDescriptor(\Liason_Location_Person.locationName, order: .reverse)]
        )
        _liasonCase = Query(
            filter: #Predicate<Liason_Location_Case> { item in
                item.locationId == targetLocationID
            },
            sort: [SortDescriptor(\Liason_Location_Case.procedureStart, order: .forward)]
        )
        self.startTime = startTime
        self.endTime = endTime
        self._scrollPosition  = scrollPosition
    }
    
    let rowHeight: CGFloat = 100
    let fontScale: CGFloat = 0.4 // 50% of the row height is a reasonable starting point
    @State private var isTargeted = false
    @State private var isCaseTargeted = false
    @State private var transPerson: PersonTrans?
    @State private var transCase: CaseTrans?
    
    struct PersonTransfer: Decodable {
        var nickName: String
        var personId: Int
    }
    
    func addLiasonPerson() {
        let liason = Liason_Location_Person(
        locationName: location.locationName,
        locationId: location.locationID,
        personNickName: transPerson?.nickName ?? "",
        personId: transPerson?.personId ?? 0,
        createdAt:  Date()
        )
        modelContext.insert(liason)
        do {
            try modelContext.save()
            print("successfully save person: \(liason)")
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    func addLiasonCase() {
        let liason = Liason_Location_Case(
            locationId: location.locationID,
            locationName: location.locationName,
            caseId: transCase?.caseId ?? 0,
            procNickname: transCase?.procNickname ?? "",
            procedureStart: transCase?.procedureStart ?? Date(),
            procedureEnd: transCase? .procedureEnd ?? Date()
        )
        
        modelContext.insert(liason)
        do {
            try modelContext.save()
            print("successfully save case: \(liason)")
        } catch {
            print("Failed to save: \(error)")
        }
    }
    var body: some View {
        HStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.blue)
                    .frame(width: rowHeight, height: rowHeight)
                
                Text(location.locationName)
                    .font(.system(size: rowHeight * fontScale, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)        // allow aggressive downscaling
                    .allowsTightening(true)         // tighter kerning when needed
                    .padding(.horizontal, 8)        // small side insets
                    .frame(height: rowHeight * fontScale)       // vertically center within rectangle
                
            }
          
    //MARK: - CASES
            ZStack {
               
                TimelineWithCases(arrayCases: liasonCase, start: startTime, end: endTime, scrollPosition: $scrollPosition)
                
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 8) {
//                        ForEach(liasonCase, id: \.self) { liason in
//                            Text(liason.procNickname)
//                                .lineLimit(1)
//                                .padding(.horizontal, 6)
//                                .padding(.vertical, 2)
//                                .background(.white.opacity(0.2))
//                                .clipShape(RoundedRectangle(cornerRadius: 4))
//                                .draggable(String(liason.id))
//                                                         }
//                    }
//                    .padding(.horizontal, 4)
//                }
                
                Rectangle()
                    .fill(.red)
                    .opacity(0.5)
            }
            .frame(maxWidth: .infinity, maxHeight: rowHeight)
            .contentShape(Rectangle())
            .dropDestination(for: CaseTrans.self, action: { items, location in
                var handled = false
                for item in items {
                    transCase = item
                    addLiasonCase()
                    handled = true
                    print("dropped case: \(item)")
                }
                return handled
            }, isTargeted: { _ in })
       //MARK: - END CASES
           
            VStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isTargeted ? .green.opacity(0.2) : .green)
                        .frame(width: rowHeight * 1.2, height: rowHeight * 0.5)
                        .contentShape(Rectangle())
                        .dropDestination(for: PersonTrans.self, action: { items, location in
                            var handled = false
                            for item in items {
                                transPerson = item
                                addLiasonPerson()
                                handled = true
                                print("dropped person: \(item)")
                            }
                            return handled
                        }, isTargeted: { targeted in
                            self.isTargeted = targeted
                        }
                                         
                        )
                    
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 8) {
                            ForEach(liasonPerson, id: \.self) { liason in
                                Text(liason.personNickName)
                                    .lineLimit(1)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(.white.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                    .draggable(String(liason.id))
                                                             }
                        }
                        .padding(.horizontal, 4)
                    }
                    
                    //Text(transPerson?.nickName ?? "")
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.yellow)
                        .frame(width: rowHeight * 1.2, height: rowHeight * 0.5)
                        .contentShape(Rectangle())
                }
            }
        }
        .frame(height: rowHeight)
        .padding(2)
    }
}
//#Preview {
//    
//    LocationRowView(location: Location(locationName: "OR 27"))
//}
//
//
//
////VStack {
////    ZStack(alignment: .topLeading) {
////        Rectangle()
////            .fill(Color.blue)
////            .frame(width: 400)
////            .frame(maxHeight: 200)
////            .dropDestination(for: String.self, action: { items, location in
//  
//  //              return //decodedAny
//   //         })
//        
////        //                        ForEach(Array(personsArray.enumerated()), id: \.offset) { _, item in
////        //                            Text(item.nickname)
////        //                                .font(.caption)
////        //                                .padding(4)
////        //                                .background(Color.white.opacity(0.8))
////        //                                .cornerRadius(4)
////        //                                .position(x: item.location.x, y: item.location.y)
////        //                        }
////    }
////}
//////                .onAppear {
//////                    if personsArray.isEmpty {
//////                        personsArray = people.map { person in
//////                            PersonTransferable(nickname: person.firstName, personID: person.personId, location: .zero)
//////                        }
//////                    }
//////                }
//
//
//
//

