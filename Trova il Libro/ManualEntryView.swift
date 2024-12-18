//
//  ManualEntryView.swift
//  Trova il Libro
//
//  Created by Marco De Vivo on 17/12/24.
//
import SwiftUI

struct ManualEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var manualBooks: [ManualBook]

    @State private var title: String = ""
    @State private var author: String = ""
    @State private var publisher: String = ""
    @State private var isbn: String = ""
    @State private var year: String = ""
    @State private var notes: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    TextField("Publisher", text: $publisher)
                    TextField("ISBN", text: $isbn)
                    TextField("Year", text: $year)
                    TextField("Notes", text: $notes)
                }

                Section {
                    Button("Save") {
                        let manualBook = ManualBook(
                            title: title,
                            author: author,
                            publisher: publisher,
                            isbn: isbn,
                            year: year,
                            notes: notes
                        )
                        manualBooks.append(manualBook)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.cyan)
                    .cornerRadius(8)
                }
            }
            .navigationTitle("Add Book")
            .navigationBarItems(leading:
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
