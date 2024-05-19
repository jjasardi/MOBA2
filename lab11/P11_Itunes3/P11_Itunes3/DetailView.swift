//
//  DetailView.swift
//  P11_Itunes3
//
//  Created by Yohan on 17.05.24.
//

import SwiftUI

struct DetailView: View {
    var album: iTunesEntry
    @State var albumDetails: [albumDetails] = []

    var body: some View {
        VStack {
            Text(albumDetails.first?.collectionName ?? "Unknown Collection")
                .font(.title)
                .padding()
            
            Text(albumDetails.first?.releaseDate.components(separatedBy: "-").first ?? "Unknown Release Year")
                .font(.title3)
                .padding()
            
            if let artworkUrl = albumDetails.first?.artworkUrl100 {
                AsyncImage(url: URL(string: artworkUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    default:
                        EmptyView()
                    }
                }
                .padding()
            }
            
            List(albumDetails.dropFirst(), id: \.id) { detail in
                HStack {
                    Text("\(detail.trackNumber ?? 0)")
                        .font(.caption)
                        .padding(.trailing, 5)
                    Text(detail.trackName ?? "Unknown Track")
                        .font(.caption)
                        .lineLimit(1)
                    Spacer()
                    
                    if let millis = detail.trackTimeMillis {
                        let seconds = millis / 1000
                        let minutes = seconds / 60
                        let remainingSeconds = seconds % 60
                        Text(String(format: "%02d:%02d", minutes, remainingSeconds))
                            .font(.caption)
                    } else {
                        Text("00:00")
                            .font(.caption)
                    }
                }
                .padding(.vertical, 5)
                
            }
            .listStyle(PlainListStyle())
            .background(Color(.systemBackground))
        }
        .task {
            do {
                self.albumDetails = try await DataManager.shared.searchAlbumDetails(for: album.collectionId)
            } catch {
                fatalError("Couldn't load album details: \(error)")
            }
        }
        .navigationTitle("Album Detail")
    }
}
