//
//  Clothing.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 3/17/24.
//

import Foundation
import SwiftUI

struct ClothingItem: Identifiable {
    
//    enum ClothingType: String, CaseIterable{
//        case Top, Bottom, Footwear
//    }

    var name: String = ""
    var color: String = ""
    var image: Image = Image(systemName: "tshirt.fill")
    var category: String = ""
    let id = UUID()
//    }
//
//    struct Bottom: Identifiable{
//        var name: String = ""
//        var color: String = ""
//        var image: Image = Image(systemName: "tshirt.fill")
//        let id = UUID()
//    }
//
//    struct Footwear: Identifiable{
//        var name: String = ""
//        var color: String = ""
//        var image: Image = Image(systemName: "tshirt.fill")
//        let id = UUID()
//    }
    
}
