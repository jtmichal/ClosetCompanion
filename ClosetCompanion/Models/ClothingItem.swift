//
//  Clothing.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 3/17/24.
//

import Foundation
import SwiftUI

struct ClothingItem {
    
    enum ClothingType: String, CaseIterable{
        case Top, Bottom, Footwear
    }
    
    struct Top: Identifiable{
        var name: String = ""
        var color: String = ""
        var image: Image = Image(systemName: "tshirt.fill")
        let id = UUID()
    }

    struct Bottom: Identifiable{
        var name: String = ""
        var color: String = ""
        var image: Image = Image(systemName: "tshirt.fill")
        let id = UUID()
    }

    struct Footwear: Identifiable{
        var name: String = ""
        var color: String = ""
        var image: Image = Image(systemName: "tshirt.fill")
        let id = UUID()
    }
    
}
