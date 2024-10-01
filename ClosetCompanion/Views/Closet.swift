//
//  Closet.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 10/19/23.
//

import SwiftUI

struct ClosetView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var showingSheet = false
    //Environment Object shares data across multiple views
    
    var body: some View {
        
        VStack(alignment: .leading){
            Button("Add", systemImage: "plus"){
                showingSheet.toggle()
                    
            }
            .sheet(isPresented: $showingSheet){
                AddClothingItem()
            }
            .labelStyle(.iconOnly)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 8)
            .font(.system(size: 32))
            Text("Tops")
                .font(.title)
                .padding(.top, 20)
                .padding(.leading, 10)
            ZStack {
                Row(itemType: "tops")
            }
            .frame(height: 100.0)
            .background(Color("Row_Backround"))
                
            
            Text("Bottoms")
                .font(.title)
                .padding(.top, 40)
                .padding(.leading, 10)
            ZStack {
                Row(itemType: "bottoms")
            }
            .frame(height: 100.0)
            .background(Color("Row_Backround"))
            
            Text("Footwear")
                .font(.title)
                .padding(.top, 40)
                .padding(.leading, 10)
            ZStack {
                Row(itemType: "footwear")
            }
            .frame(height: 100.0)
            .background(Color("Row_Backround"))
            
            Color.white
        }
    }
}

struct Row: View{
    var filter = "Top"
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "category like 'Top'")) var clothingItems: FetchedResults<ClothingItemData>
    @Environment(\.managedObjectContext) var moc
    
    @State private var filterByCategory = "Top"
    @State private var showingItemDetails = false
    @State private var passedItem : FetchedResults<ClothingItemData>.Element = FetchedResults<ClothingItemData>.Element() //value to be passed to detailedClothingItem
    @State private var testingItem = ClothingItem()
    
    var itemType : String
    var defaultImage = UIImage()

    let new = ClothingItem()

    var body: some View{
        switch itemType {
        case "tops":
            ScrollView(.horizontal){
                HStack(spacing:20){
                    ForEach(clothingItems) {top in
                        Image(uiImage: UIImage(data: top.image ?? Data()) ?? defaultImage)
                                .resizable()
                                .imageScale(.large)
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    showingItemDetails.toggle()
                                    passedItem = top;
                                }
                        }
                        .sheet(isPresented: $showingItemDetails){
                            DetailedClothingItem(clothingItem: $testingItem, passedItem: $passedItem)
                        }
                }
            }
            .padding(0.0)
            .font(.system(size: 32))
        case "bottoms":
            ScrollView(.horizontal){
                HStack(spacing:20){
                        ForEach(clothingItems) {bottom in
                            Image(uiImage: UIImage(data: bottom.image ?? Data()) ?? defaultImage)
                                .resizable()
                                .imageScale(.large)
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    showingItemDetails.toggle()
                                    passedItem = bottom;
                                }
                        }
                        .sheet(isPresented: $showingItemDetails){
                            DetailedClothingItem(clothingItem: $testingItem, passedItem: $passedItem)
                        }
                }
            }
            .padding(0.0)
            .font(.system(size: 32))
        case "footwear":
            ScrollView(.horizontal){
                HStack(spacing:20){
                    ForEach(clothingItems) {footwear in
                            Image(uiImage: UIImage(data: footwear.image ?? Data()) ?? defaultImage)
                                .resizable()
                                .imageScale(.large)
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    showingItemDetails.toggle()
                                    passedItem = footwear;
                                }
                        }
                        .sheet(isPresented: $showingItemDetails){
                            DetailedClothingItem(clothingItem: $testingItem, passedItem: $passedItem)
                        }
                }
            }
            .padding(0.0)
            .font(.system(size: 32))
        default:
            Image(systemName: "tshirt.fill")
        }
    }
    
}

struct Closet_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView()
    }
}
