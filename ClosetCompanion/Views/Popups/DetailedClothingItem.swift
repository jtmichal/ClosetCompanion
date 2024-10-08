//
//  DetailedClothingItem.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 6/6/24.
//

import Foundation
import SwiftUI

struct DetailedClothingItem: View{
    @Binding var passedItem : FetchedResults<ClothingItemData>.Element
    
    @Environment(\.dismiss) var dismiss
    var body : some View{
        VStack{
            LabeledContent("Name: ", value: passedItem.name ?? String())
                .padding()
            LabeledContent("Color: ", value: passedItem.color ?? String())
                .padding()
            LabeledContent("Category: ", value: passedItem.category ?? String())
                .padding()
            Image(uiImage: UIImage(data: passedItem.image ?? Data()) ?? UIImage())
                .resizable()
                .frame(width: 150, height: 150)
        }
    }
}

struct DetailedClothingItem_Previews: PreviewProvider {
    @State static var passedItem = FetchedResults<ClothingItemData>.Element()
    static var previews: some View {
        DetailedClothingItem( passedItem: $passedItem)
    }
}
