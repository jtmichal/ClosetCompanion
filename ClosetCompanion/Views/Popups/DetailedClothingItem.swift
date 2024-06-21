//
//  DetailedClothingItem.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 6/6/24.
//

import Foundation
import SwiftUI

struct DetailedClothingItem: View{
    @Binding var clothingItem : ClothingItem.Top
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var closet: Closet
    var body : some View{
        VStack{
            LabeledContent("Name: ", value: clothingItem.name)
                .padding()
            LabeledContent("Color: ", value: clothingItem.color)
                .padding()
            clothingItem.image
                .resizable()
                .frame(width: 150, height: 150)
        }
    }
}

struct DetailedClothingItem_Previews: PreviewProvider {
    @State static var clothingItem = ClothingItem.Top()
    static var previews: some View {
        DetailedClothingItem(clothingItem: $clothingItem)
            .environmentObject(Closet())
    }
}
