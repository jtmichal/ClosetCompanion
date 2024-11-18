//
//  DetailedClothingItem.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 6/6/24.
//

import Foundation
import SwiftUI

struct DetailedClothingItem: View{
    var passedItem : FetchedResults<ClothingItemData>.Element
    @State var deleteIsActive: Bool = false
    
    @Environment(\.dismiss) var dismiss
    var body : some View{
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Spacer()
                    Button("Delete"){
                        deleteIsActive = true
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
                    .clipShape(Capsule())
                    .buttonStyle(.borderless)
                }
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
        
                Spacer()
                Spacer()
                Spacer()
            }
            
            if deleteIsActive {
                DeleteConfirmation(deleteIsActive: $deleteIsActive, title: "Delete Item?", message: "Are you sure you want to delete this item? This action cannot be undone.", buttonTitle: "Confirm") {
                    print("DONE")
                }
            }
        }
    }
}

struct DetailedClothingItem_Previews: PreviewProvider {
    static var passedItem = FetchedResults<ClothingItemData>.Element()
    static var previews: some View {
        DetailedClothingItem( passedItem: passedItem)
    }
}
