//
//  Home.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 10/19/23.
//

import SwiftUI

struct Home: View {
    @FetchRequest(sortDescriptors: []) var clothingItems: FetchedResults<ClothingItemData>
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        VStack{

            
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
