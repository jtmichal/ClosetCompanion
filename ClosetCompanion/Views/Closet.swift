//
//  Closet.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 10/19/23.
//

import SwiftUI

class Closet: ObservableObject {
    init(clothingItem: [ClothingItem] = [ClothingItem](),
         topsPile: [ClothingItem] = [ClothingItem](),
         bottomsPile: [ClothingItem] = [ClothingItem](),
         footwearPile: [ClothingItem] = [ClothingItem]()){
        
        self.clothingItem = clothingItem
        self.topsPile = topsPile
        self.bottomsPile = bottomsPile
        self.footwearPile = footwearPile
    }
    @Published var clothingItem = [ClothingItem]()
    @Published var topsPile = [ClothingItem]()
    @Published var bottomsPile = [ClothingItem]()
    @Published var footwearPile = [ClothingItem]()
    
    func addTop(top: ClothingItem){
        topsPile.append(top)

    }
    
    func addBottom(bottom: ClothingItem){
        bottomsPile.append(bottom)
    }
    
    func addFootwear(footwear: ClothingItem){
        footwearPile.append(footwear)
    }
}
struct ClosetView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var showingSheet = false
    @EnvironmentObject var closet: Closet
    //Environment Object shares data across multiple views
    
    var body: some View {
        
        VStack(alignment: .leading){
            Button("Add", systemImage: "plus"){
                showingSheet.toggle()
                    
            }
            .sheet(isPresented: $showingSheet){
                AddClothingItem()
                    .environmentObject(closet)
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
                Row(itemType: "tops", topsPile: closet.topsPile, bottomsPile: closet.bottomsPile, footwearPile: closet.footwearPile)
            }
            .frame(height: 100.0)
            .background(Color("Row_Backround"))
                
            
            Text("Bottoms")
                .font(.title)
                .padding(.top, 40)
                .padding(.leading, 10)
            ZStack {
                Row(itemType: "bottoms", topsPile: closet.topsPile, bottomsPile: closet.bottomsPile, footwearPile: closet.footwearPile)
            }
            .frame(height: 100.0)
            .background(Color("Row_Backround"))
            
            Text("Footwear")
                .font(.title)
                .padding(.top, 40)
                .padding(.leading, 10)
            ZStack {
                Row(itemType: "footwear",topsPile: closet.topsPile, bottomsPile: closet.bottomsPile, footwearPile: closet.footwearPile)
            }
            .frame(height: 100.0)
            .background(Color("Row_Backround"))
            
            Color.white
        }
    }
}

struct Row: View{
    @FetchRequest(sortDescriptors: []) var clothingItems: FetchedResults<ClothingItemData>
    @Environment(\.managedObjectContext) var moc
    
    @EnvironmentObject var closet: Closet
    @State private var showingItemDetails = false
    @State private var passedItem : FetchedResults<ClothingItemData>.Element = FetchedResults<ClothingItemData>.Element() //value to be passed to detailedClothingItem
    @State private var testingItem = ClothingItem()
    var itemType : String
    var topsPile : [ClothingItem]
    var bottomsPile : [ClothingItem]
    var footwearPile : [ClothingItem]
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
        case "footwear":
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
        default:
            Image(systemName: "tshirt.fill")
        }
    }
    
}

struct Closet_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView()
            .environmentObject(Closet())
    }
}
