//
//  ManualBook.swift
//  Trova il Libro
//
//  Created by Marco De Vivo on 18/12/24.
//
import Foundation

struct ManualBook: Identifiable, Codable {
    var id: UUID = UUID() // Identificatore univoco
    let title: String
    let author: String
    let publisher: String
    let isbn: String
    let year: String
    let notes: String
}
