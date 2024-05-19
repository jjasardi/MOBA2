//
//  ContentView.swift
//  P09_Itunes
//
//  Created by Yohan on 19.04.24.
//

import SwiftUI

struct ContentView: View {
    @State var data: [iTunesEntry] = []
    
    var body: some View {
        VStack {
            List(data) { entry in
                HStack(spacing: 10) {
                    AsyncImage(url: URL(string: entry.artworkUrl60)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 30, height: 30)
                    
                    Text(entry.collectionName)
                }
            }
            .task {
                do {
                    self.data = try await loadData()
                } catch {
                    fatalError("Couldn't load file \(error)")
                }
            }
        }
        .padding()
    }
    
    func loadData() async throws -> [iTunesEntry] {
            let file = Bundle.main.url(forResource: "stones", withExtension: "json")
            let data = try Data(contentsOf: file!)
            let decoder = JSONDecoder()
            let sjson = try decoder.decode(iTunesJSON.self, from: data)
            return sjson.results
        }

}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
