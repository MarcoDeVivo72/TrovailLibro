//
//  ApimanagerVm.swift
//  Trova il Libro
//
//  Created by Marco De Vivo on 13/12/24.
//
import Foundation

@MainActor
class ApimanagerVm: ObservableObject {
    @Published var books: [Docs] = [] // Lista dei libri restituiti dall'API

    // Funzione per ottenere i libri tramite il titolo
    func getBooks(title: String) {
        if let url = URL(string: "https://openlibrary.org/search.json?title=\(title)") {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let searchResult = try decoder.decode(Datas.self, from: safeData)
                        DispatchQueue.main.async {
                            self.books = searchResult.docs
                        }
                        if let firstBook = searchResult.docs.first {
                            print(firstBook.authorName?.first ?? "Unknown author")
                        }
                    } catch let error as NSError {
                        print("Error decoding data: \(error.localizedDescription)")
                    }
                }
            }

            task.resume()
        }
    }
}
