//
//  ContentView.swift
//  Trova il Libro
//
//  Created by Marco De Vivo on 12/12/24.
//
import SwiftUI

struct ContentView: View {
    @State private var title: String = ""  // Per la ricerca tramite API
    @State private var book: Datas?       // Risultati dalla ricerca API
    @StateObject private var bookapi = ApimanagerVm()
    @State private var savedBooks: [Docs] = []    // Libri salvati dall'API
    @State private var manualBooks: [ManualBook] = [] // Libri aggiunti manualmente
    @State private var showManualEntry = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.cyan.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Text("Find Book")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                    TextField("Insert Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.gray)
                        .cornerRadius(8)

                    HStack {
                        Button {
                            bookapi.getBooks(title: title)
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.cyan)
                                .clipShape(Circle())
                        }

                        NavigationLink {
                            GalleryView(savedBooks: $savedBooks, manualBooks: $manualBooks)
                        } label: {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.cyan)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.bottom, 20)

                    ScrollView {
                        LazyVStack {
                            ForEach(book?.docs ?? bookapi.books, id: \.id) { datas in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(datas.title)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        if let authors = datas.authorName, !authors.isEmpty {
                                            Text("Author: \(authors.joined(separator: ", "))")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding()

                                    Spacer()

                                    Button(action: {
                                        if !savedBooks.contains(where: { $0.title == datas.title }) {
                                            savedBooks.append(datas)
                                        }
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.yellow)
                                            .padding()
                                    }
                                }
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(10)

                    Spacer()
                }
                .padding()
                .navigationBarItems(trailing:
                    Button(action: {
                        showManualEntry.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    }
                )
                .sheet(isPresented: $showManualEntry) {
                    ManualEntryView(manualBooks: $manualBooks)
                }
            }
        }
    }
}

