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

struct JSONFile: Decodable {
    var results : [Album]
}

struct Home: View {
    @State var albums : [Album] = [Album]()
    var body: some View {
        VStack {
            List (albums) { album in
                HStack {
                    AsyncImage(url: URL(string: album.artworkUrl60))
                    Text(album.collectionName)
                }
            }.task {
                do {
                      self.albums = try await loadData()
                }
                catch {NSLog("\(error)")}
            }
        }.padding()
    }
}

func loadData() async throws -> [Album] {
    let file = Bundle.main.url(forResource: "stones", withExtension: "json")
    //create a data instance
    let data = try Data(contentsOf: file!)
    let decoder = JSONDecoder()
    let sjson = try decoder.decode(JSONFile.self, from: data)
    return sjson.results
}

#Preview {
    Home()
}
