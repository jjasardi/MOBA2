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
    var collectionId : Int
    
    var id : String {
        return UUID().uuidString
    }
}

class albumDetailsJSON: Decodable {
    var results : [albumDetails]
}

class albumDetails : Decodable, Identifiable {
    
    var collectionName : String
    var releaseDate : String
    var artworkUrl100 : String
    var trackNumber : Int?
    var trackName : String?
    var trackTimeMillis : Int?
    
    var id : String {
        return UUID().uuidString
    }
    
}
