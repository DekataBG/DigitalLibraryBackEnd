import Fluent
import struct Foundation.UUID
import struct Foundation.Date

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
final class Book: Model, @unchecked Sendable {
    static let schema = "books"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String

    @Field(key: "author")
    var author: String

    @Field(key: "publisher")
    var publisher: String

    @Field(key: "year")
    var year: Int

    @Field(key: "genre")
    var genre: String

    @Field(key: "isbn")
    var isbn: String

    @Field(key: "returning-deadline")
    var returningDeadline: Date?

    @Field(key: "is-taken")
    var isTaken: Bool

    init() { }

    init(id: UUID? = UUID(),
         title: String,
         description: String,
         author: String,
         publisher: String,
         year: Int,
         genre: String,
         isbn: String,
         returningDeadline: Date? = nil,
         isTaken: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.author = author
        self.publisher = publisher
        self.year = year
        self.genre = genre
        self.isbn = isbn
        self.returningDeadline = returningDeadline
        self.isTaken = isTaken
    }

    func toDTO() -> BookDTO {
        .init(id: id, 
              title: title,
              description: description,
              author: author,
              publisher: publisher,
              year: year,
              genre: genre,
              isbn: isbn,
              returningDeadline: returningDeadline,
              isTaken: isTaken)
    }
}
