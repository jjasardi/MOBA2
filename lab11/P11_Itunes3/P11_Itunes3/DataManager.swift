//
//  DataManager.swift
//  P10_Itunes2
//
//  Created by Yohan on 17.05.24.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func loadData() async throws -> [iTunesEntry] {
        let apiUrlString = "https://itunes.apple.com/search?term=rolling+stones&entity=album"
        
        guard let apiUrl = URL(string: apiUrlString) else {
            throw NSError(domain: "InvalidURL", code: -1, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: apiUrl)
        
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(iTunesJSON.self, from: data)
        
        return searchResponse.results
    }
    
    func searchAlbum(for searchTerm: String) async throws -> [iTunesEntry] {
        let encodedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let apiUrlString = "https://itunes.apple.com/search?term=\(encodedSearchTerm)&entity=album"
        
        guard let apiUrl = URL(string: apiUrlString) else {
            throw NSError(domain: "InvalidURL", code: -1, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: apiUrl)
        
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(iTunesJSON.self, from: data)
        
        return searchResponse.results
    }
    
    func searchAlbumDetails(for collectionId: Int) async throws -> [albumDetails] {
        let apiUrlString = "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song"
        
        print(apiUrlString)
        
        guard let apiUrl = URL(string: apiUrlString) else {
            throw NSError(domain: "InvalidURL", code: -1, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: apiUrl)
        
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(albumDetailsJSON.self, from: data)
        
        print(searchResponse.results)
        
        return searchResponse.results
    }

    
}
