//
//  ContentView.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 10/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var defaultTab = 2
    
    var body: some View {
        
        TabView(selection:$defaultTab){
            ClosetView()
                .tabItem(){
                    Image(systemName: "door.french.open")
                    Text("Closet")
                }
                .tag(1)
                .environmentObject(Closet())
            Home()
                .tabItem(){
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(2)
                .environmentObject(Closet())
            Profile()
                .tabItem(){
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
                .environmentObject(Closet())
        }
    }
}
//test

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
