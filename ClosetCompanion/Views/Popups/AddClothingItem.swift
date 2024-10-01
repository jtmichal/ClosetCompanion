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
    @FetchRequest(sortDescriptors: []) var clothingItems: FetchedResults<ClothingItemData>
    @Environment(\.managedObjectContext) var moc
    
    enum ItemCategory: String, CaseIterable, Identifiable {
        case Top, Bottom, Footwear
        var id: Self { self }
    }
    
    @Environment(\.dismiss) var dismiss
    @State private var itemName: String = ""
    @State private var itemColor: String = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var itemImage: Image = Image(systemName: "tshirt.fill")
    @State private var itemCategory: ItemCategory = .Top
    @FocusState private var nameFieldIsFocused: Bool
    
    var body : some View{
        NavigationView {
            Form{
                Section(header: Text("Name")){
                    List{
                        Picker("Item Type:", selection: $itemCategory){
                            Text("Top").tag(ItemCategory.Top)
                            Text("Bottom").tag(ItemCategory.Bottom)
                            Text("Footwear").tag(ItemCategory.Footwear)
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
        let clothingItem = ClothingItemData(context: moc)
        
        clothingItem.id = UUID()
        clothingItem.name = itemName;
        clothingItem.color = itemColor;
        clothingItem.image = ImageRenderer(content: itemImage).uiImage?.jpegData(compressionQuality: 0);
        clothingItem.category = itemCategory.rawValue;
        
        do {try moc.save()
        }catch{
            print("catch: \(error)")
        }
        dismiss()
    }
}

struct AddClothingItem_Previews: PreviewProvider {
    static var previews: some View {
        AddClothingItem()
    }
}
