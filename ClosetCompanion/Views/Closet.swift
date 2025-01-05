//
//  Closet.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 10/19/23.
//

import SwiftUI

struct ClosetView: View {
    //------Fetch Requests------//
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "category like 'Top'")) var topsPile: FetchedResults<ClothingItemData>
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "category like 'Bottom'")) var bottomsPile: FetchedResults<ClothingItemData>
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "category like 'Footwear'")) var footwearPile: FetchedResults<ClothingItemData>
    //--------------------------//
    
    @Environment(\.dismiss) var dismiss
    @State private var showingSheet = false
    @State private var action: Int? = 0
    var categories: [(String, FetchedResults<ClothingItemData>)]{
        [
         ("Tops", topsPile),
         ("Bottoms", bottomsPile),
         ("Footwear", footwearPile),
        ]
    }
    
    //Environment Object shares data across multiple views

    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                NavigationLink(destination: AddClothingItem(clothingItem: nil)){
                    Image(systemName: "plus")
                    .labelStyle(.iconOnly)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 8)
                    .font(.system(size: 32))
                }
                
                ForEach(categories, id:\.0){category in
                    Text(category.0)
                        .font(.title)
                        .padding(.top, 20)
                        .padding(.leading, 10)
                    ZStack {
                        Row(itemType: "\(category.0)", pile: category.1)
                    }
                    .frame(height: 140.0)
                    .background(Color("Row_Backround"))
                }
                
                Color.white
            }
        }
    }
}

struct Row: View{
    @Environment(\.managedObjectContext) var moc
    
    //to decide when to open detailed information for given item
    @State private var showingItemDetails = false
    //value to be passed to detailedClothingItem
    @State private var passedItem = FetchedResults<ClothingItemData>.Element()
    
    var itemType : String
    var defaultImage = UIImage()
    var pile : FetchedResults<ClothingItemData>

    var body: some View{
        NavigationStack{
            ScrollView(.horizontal){
                HStack(spacing:20){
                    ForEach(pile) {item in
                        NavigationLink(destination: DetailedClothingItem(passedItem: item)){
                            Image(uiImage: UIImage(data: item.image ?? Data()) ?? defaultImage)
                                .resizable()
                                .imageScale(.large)
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
            .padding(0.0)
            .font(.system(size: 32))
        }
    }
}

struct Closet_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView()
    }
}
