//
//  AddClothingItem.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 2/22/24.
//

import Foundation
import SwiftUI
import PhotosUI


struct AddClothingItem: View{
    @Environment(\.dismiss) var dismiss
    @State private var selectedItemType: ClothingItem.ClothingType = .Top
    @State private var itemName: String = ""
    @State private var itemColor: String = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var itemImage: Image = Image(systemName: "tshirt.fill")
    @FocusState private var nameFieldIsFocused: Bool
    @EnvironmentObject var closet: Closet
    
    var body : some View{
        NavigationView {
            Form{
                Section(header: Text("Name")){
                    List{
                        Picker("Item Type:", selection: $selectedItemType){
                            Text("Top").tag(ClothingItem.ClothingType.Top)
                            Text("Bottom").tag(ClothingItem.ClothingType.Bottom)
                            Text("Footwear").tag(ClothingItem.ClothingType.Footwear)
                        }
                    }
                    
                    TextField("Enter Item Name", text: $itemName)
                    TextField("Enter Item Color", text: $itemColor)
                    
                    PhotosPicker("Choose Image", selection: $photoItem, matching: .images)
                            itemImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                            .onChange(of: photoItem) {
                                Task {
                                    if let loaded = try? await photoItem?.loadTransferable(type: Image.self) {
                                        itemImage = loaded
                                    } else {
                                        print("Failed")
                                    }
                                }
                            }
 
                }
                HStack{
                    Spacer()
                    
                    Button("Add Item"){
                        addTop()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(Capsule())
                    .buttonStyle(.borderless)
                    
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
                    .clipShape(Capsule())
                    .buttonStyle(.borderless)
                    
                    Spacer()
                }.listRowBackground(Color(.systemGroupedBackground))
            }
        }
    }
    func addTop(){
        let new = ClothingItem.Top(name:itemName,color:itemColor,image:itemImage);
        closet.addTop(top:new)
        dismiss()
    }
}

struct AddClothingItem_Previews: PreviewProvider {
    static var previews: some View {
        AddClothingItem()
            .environmentObject(Closet())
    }
}
