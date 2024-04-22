//
//  Home.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 10/19/23.
//

import SwiftUI

struct Home: View {
    @State private var showingSheet = false
    var body: some View {
        
        Button("Show Sheet"){
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet){
            AddClothingItem()
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
