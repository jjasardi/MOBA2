//
//  ContentView.swift
//  ITunes practice9
//
//  Created by Lokaladmin on 03.05.2024.
//

import SwiftUI

struct Album : Identifiable, Decodable {
    var collectionName : String
    var artworkUrl60 : String
    var id : String {
        return UUID().uuidString
    }
}

struct JSONresult: Decodable {
    var results : [Album]
}

struct Home: View {
    @State var searchText : String = ""
    @State var albums : [Album] = [Album]()
    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .onSubmit {
                    Task {
                        do {
                              self.albums = try await loadData(searchTerm: searchText)
                        }
                        catch {NSLog("\(error)")}
                    }
                }
            List (albums) { album in
                HStack {
                    AsyncImage(url: URL(string: album.artworkUrl60))
                    Text(album.collectionName)
                }
            }
        }.padding()
    }
}

func loadData(searchTerm: String) async throws -> [Album] {
    let encodedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let (data, _) = try await URLSession.shared.data(from:URL(string:"https://itunes.apple.com/search?term=\(encodedSearchTerm)&entity=album")!)
    let decoder = JSONDecoder()
    let sjson = try decoder.decode(JSONresult.self, from: data)
    return sjson.results
}

#Preview {
    Home()
}
