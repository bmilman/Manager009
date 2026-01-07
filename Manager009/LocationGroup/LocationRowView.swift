//
//  LocationRowView.swift
//  Manager009
//
//  Created by bernard milman on 1/6/26.
//

import SwiftUI

struct LocationRowView: View {
    
    var location: Location
    
    let rowHeight: CGFloat = 100
    let fontScale: CGFloat = 0.4 // 50% of the row height is a reasonable starting point
    @State private var isTargeted = false
    @State private var transPerson: PersonTransfer?
    
    struct PersonTransfer: Decodable {
        var nickName: String
        var personId: Int
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
            ZStack {
                Rectangle()
                    .fill(.red)
                    .frame(minWidth: rowHeight,  maxWidth: rowHeight * 5, minHeight: rowHeight, maxHeight: rowHeight)
                    
                    //.aspectRatio(1, contentMode: .fit)
                
            }
            //.allowsHitTesting(false)

            GeometryReader { geometry in
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isTargeted ? .green.opacity(0.2) : .green)
                        .frame(width: rowHeight * 2, height: rowHeight)
                        .contentShape(Rectangle())
                        .dropDestination(for: String.self, action: { items, location in
                            let decoder = JSONDecoder()
                            var decodedAny = false
                            for item in items {
                                if let data = item.data(using: .utf8),
                                   let personTransferable = try? decoder.decode(PersonTransfer.self, from: data) {
                                   transPerson = personTransferable
                                    print("decode successful: \(transPerson?.nickName ?? "")")
                                    //personTransferable.location = location
                                    decodedAny = true
                                } else {
                                    print("Failed to decode dropped item as PersonTransferable JSON: \(item)")
                                }
                            }
                            print("dropped", items, location)
                            return decodedAny
                        }, isTargeted: { targeted in
                            isTargeted = targeted
                        })
                    Text(transPerson?.nickName ?? "")
                       // .draggable()
                }
                //.allowsHitTesting(true)
            }
        }
        .frame(height: rowHeight)
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

