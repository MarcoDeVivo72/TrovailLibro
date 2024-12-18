import Foundation

struct Datas: Codable {
    let numFound: Int
    let docs: [Docs] // Array dei libri

    enum CodingKeys: String, CodingKey {
        case numFound = "num_found"
        case docs
    }
}

struct Docs: Codable, Identifiable {
    var id: UUID = UUID() // Identificatore locale univoco
    let title: String
    let authorName: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case authorName = "author_name"
    }
}

