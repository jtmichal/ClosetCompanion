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
            List(clothingItems){ clothingItem in
                Text(clothingItem.name ?? "Unknown")
            }
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                
                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!
                
                let clothingItem = ClothingItemData(context: moc)
                clothingItem.id = UUID()
                clothingItem.name = "\(chosenFirstName) \(chosenLastName)"
                
                do {try moc.save()
                }catch{
                    print("catch: \(error)")
                }
            }
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
