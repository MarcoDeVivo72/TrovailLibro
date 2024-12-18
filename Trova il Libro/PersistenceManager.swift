//
//  PersistenceManager.swift
//  Trova il Libro
//
//  Created by Marco De Vivo on 18/12/24.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    private let key = "SavedBooks"

    private init() {}

    func saveBooks(_ books: [Docs]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(books)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Error saving books: \(error.localizedDescription)")
        }
    }

    func loadBooks() -> [Docs] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Docs].self, from: data)
        } catch {
            print("Error loading books: \(error.localizedDescription)")
            return []
        }
    }
}
