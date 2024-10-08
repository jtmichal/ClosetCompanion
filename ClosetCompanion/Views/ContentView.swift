//
//  ContentView.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 10/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var defaultTab = 2
    @FetchRequest(sortDescriptors: []) var clothingItems: FetchedResults<ClothingItemData>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        
        TabView(selection:$defaultTab){
            ClosetView()
                .tabItem(){
                    Image(systemName: "door.french.open")
                    Text("Closet")
                }
                .tag(1)
            Home()
                .tabItem(){
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(2)
            Profile()
                .tabItem(){
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
