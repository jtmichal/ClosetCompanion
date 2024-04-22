//
//  Closet.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 10/19/23.
//

import SwiftUI

class Closet: ObservableObject {
    init(clothingItem: [ClothingItem] = [ClothingItem](),
         topsPile: [ClothingItem.Top] = [ClothingItem.Top](),
         bottomsPile: [ClothingItem.Bottom] = [ClothingItem.Bottom](),
         footwearPile: [ClothingItem.Footwear] = [ClothingItem.Footwear]()){
        
        self.clothingItem = clothingItem
        self.topsPile = topsPile
        self.bottomsPile = bottomsPile
        self.footwearPile = footwearPile
    }
    @Published var clothingItem = [ClothingItem]()
    @Published var topsPile = [ClothingItem.Top]()
    @Published var bottomsPile = [ClothingItem.Bottom]()
    @Published var footwearPile = [ClothingItem.Footwear]()
    
    func addTop(top: ClothingItem.Top){
        topsPile.append(top)
    }
    
    func addBottom(){
        let new = ClothingItem.Bottom(name: "New",
                       color: "Blue")
        bottomsPile.append(new)
    }
    
    func addFootwear(){
        let new = ClothingItem.Footwear(name: "New",
                       color: "Blue")
        footwearPile.append(new)
    }
}
struct ClosetView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var showingSheet = false
    @EnvironmentObject var closet: Closet
    
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
    @EnvironmentObject var closet: Closet
    var itemType : String
    var topsPile : [ClothingItem.Top]
    var bottomsPile : [ClothingItem.Bottom]
    var footwearPile : [ClothingItem.Footwear]
    
    let new = ClothingItem.Top()
    
    var body: some View{
        switch itemType {
        case "tops":
            ScrollView(.horizontal){
                HStack(spacing:20){
                    if !topsPile.isEmpty{
                        ForEach(topsPile) {top in
                            Image(systemName: "tshirt.fill")
                        }
                        .imageScale(.large)
                    }
                }
            }
            .padding(0.0)
            .font(.system(size: 32))
        case "bottoms":
            ScrollView(.horizontal){
                HStack(spacing:20){
                    if !bottomsPile.isEmpty{
                        ForEach(bottomsPile) {bottom in
                            Image(systemName: "tshirt.fill")
                        }
                        .imageScale(.large)
                    }
                }
            }
            .padding(0.0)
            .font(.system(size: 32))
        case "footwear":
            ScrollView(.horizontal){
                HStack(spacing:20){
                    if !footwearPile.isEmpty{
                        ForEach(footwearPile) {footwear in
                            Image(systemName: "tshirt.fill")
                        }
                        .imageScale(.large)
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
