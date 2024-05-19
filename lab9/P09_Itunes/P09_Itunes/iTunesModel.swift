//
//  iTunesJSON.swift
//  P09_Itunes
//
//  Created by Yohan on 26.04.24.
//

import Foundation

class iTunesJSON: Decodable {
    var results : [iTunesEntry]
}

class iTunesEntry : Decodable, Identifiable {
 
    var collectionName : String
    var artworkUrl60 : String
    
    var id : String {
        return UUID().uuidString
    }
}
