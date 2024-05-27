import Fluent
import Vapor

struct BookDTO: Content {
    let id: UUID?
    let title: String
    let description: String
    let author: String
    let publisher: String
    let year: Int
    let genre: String
    let isbn: String
    let returningDeadline: Date?
    let isTaken: Bool

    func toModel() -> Book {
        let model = Book()

        model.id = id
        model.title = title
        model.description = description
        model.author = author
        model.publisher = publisher
        model.year = year
        model.genre = genre
        model.isbn = isbn
        model.returningDeadline = returningDeadline
        model.isTaken = isTaken

        return model
    }
}
