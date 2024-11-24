//
//  DetailedClothingItem.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 6/6/24.
//

import Foundation
import SwiftUI

struct DetailedClothingItem: View{
    @FetchRequest(sortDescriptors: []) var clothingItems: FetchedResults<ClothingItemData>
    var passedItem : FetchedResults<ClothingItemData>.Element
    @State var deleteIsActive: Bool = false
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.dismiss) var dismiss
    
    func removeClothingItem(){
            moc.delete(passedItem)
        do{
            try moc.save()
        } catch {
            print("HUH")
        }
    }
    
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
                    removeClothingItem()
                    dismiss()
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
