//
//  ContentView.swift
//  P10_Itunes2
//
//  Created by Yohan on 17.05.24.
//

import SwiftUI

struct ContentView: View {
    @State var data: [iTunesEntry] = []
    @State var search: String = ""
    @State private var isListViewActive = false
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var showNoMatchMessage = false

    var body: some View {
        VStack {
            TextField("Search", text: $search)
                .padding()
            
            Button(action: {
                if isValidSearch(search) {
                    isLoading = true
                    showNoMatchMessage = false
                    Task {
                        do {
                            self.data = try await DataManager.shared.searchAlbum(for: search)
                            search = ""
                            if self.data.isEmpty {
                                showNoMatchMessage = true
                            } else {
                                self.isListViewActive = true
                            }
                        } catch {
                            print("Error: \(error)")
                        }
                        isLoading = false
                    }
                } else {
                    showAlert = true
                }
            }) {
                Text("Search")
            }
            
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
                    self.data = try await DataManager.shared.loadData()
                } catch {
                    fatalError("Couldn't load file \(error)")
                }
            }
        }
        .padding()
    }

    
    private func isValidSearch(_ searchTerm: String) -> Bool {
        let trimmedSearchTerm = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedSearchTerm.isEmpty
    }
}
