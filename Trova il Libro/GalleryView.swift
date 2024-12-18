//
//  GalleryView.swift
//  Trova il Libro
//
//  Created by Marco De Vivo on 12/12/24.
//

import SwiftUI

struct GalleryView: View {
    @Binding var savedBooks: [Docs]        // Libri salvati tramite API
    @Binding var manualBooks: [ManualBook] // Libri aggiunti manualmente

    var body: some View {
        ZStack {
            Color.cyan.edgesIgnoringSafeArea(.all)

            VStack {
                // Titolo della galleria
                Text("Gallery")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 10)
                
                // Lista combinata di libri salvati
                List {
                    // Sezione per i libri salvati dall'API
                    if !savedBooks.isEmpty {
                        Section(header: Text("Books from API")) {
                            ForEach(savedBooks) { book in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(book.title)
                                            .font(.headline)
                                        if let authors = book.authorName {
                                            Text("Author: \(authors.joined(separator: ", "))")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    Spacer()
                                    // Pulsante per rimuovere il libro
                                    Button(action: {
                                        if let index = savedBooks.firstIndex(where: { $0.id == book.id }) {
                                            savedBooks.remove(at: index)
                                        }
                                        saveBooks() // Salva i dati dopo la rimozione
                                    }) {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding()
                            }
                            .onDelete { indices in
                                savedBooks.remove(atOffsets: indices)
                                saveBooks()  // Salva i dati ogni volta che vengono modificati
                            }
                        }
                    }
                    
                    // Sezione per i libri aggiunti manualmente
                    if !manualBooks.isEmpty {
                        Section(header: Text("Manually Added Books")) {
                            ForEach(manualBooks) { book in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(book.title)
                                            .font(.headline)
                                        Text("Author: \(book.author)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text("Publisher: \(book.publisher)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text("ISBN: \(book.isbn)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text("Year: \(book.year)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        if !book.notes.isEmpty {
                                            Text("Notes: \(book.notes)")
                                                .font(.footnote)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    Spacer()
                                    // Pulsante per rimuovere il libro
                                    Button(action: {
                                        if let index = manualBooks.firstIndex(where: { $0.id == book.id }) {
                                            manualBooks.remove(at: index)
                                        }
                                        saveBooks() // Salva i dati dopo la rimozione
                                    }) {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding()
                            }
                            .onDelete { indices in
                                manualBooks.remove(atOffsets: indices)
                                saveBooks()  // Salva i dati ogni volta che vengono modificati
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle()) // Per un aspetto migliore della lista
                .padding(.top, 10)
            }
        }
        .onAppear {
            loadBooks()  // Carica i dati quando la vista appare
        }
    }
    
    // Funzione per salvare i libri in UserDefaults
    func saveBooks() {
        // Salva i dati salvati tramite API
        if let encodedSavedBooks = try? JSONEncoder().encode(savedBooks) {
            UserDefaults.standard.set(encodedSavedBooks, forKey: "savedBooks")
        }
        
        // Salva i libri manuali
        if let encodedManualBooks = try? JSONEncoder().encode(manualBooks) {
            UserDefaults.standard.set(encodedManualBooks, forKey: "manualBooks")
        }
    }
    
    // Funzione per caricare i libri da UserDefaults
    func loadBooks() {
        if let savedData = UserDefaults.standard.data(forKey: "savedBooks"),
           let decodedBooks = try? JSONDecoder().decode([Docs].self, from: savedData) {
            savedBooks = decodedBooks
        }
        
        if let manualData = UserDefaults.standard.data(forKey: "manualBooks"),
           let decodedManualBooks = try? JSONDecoder().decode([ManualBook].self, from: manualData) {
            manualBooks = decodedManualBooks
        }
    }
}

