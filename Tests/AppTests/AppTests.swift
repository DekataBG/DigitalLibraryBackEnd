@testable import App
import XCTVapor
import Fluent

final class AppTests: XCTestCase {
    var app: Application!
    
    override func setUp() async throws {
        self.app = try await Application.make(.testing)
        try await configure(app)
        try await app.autoMigrate()
    }
    
    override func tearDown() async throws { 
        try await app.autoRevert()
        try await self.app.asyncShutdown()
        self.app = nil
    }
    
    func testHelloWorld() async throws {
        try await self.app.test(.GET, "hello", afterResponse: { res async in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Hello, world!")
        })
    }
    
    func testBookIndex() async throws {
        let sampleBooks = [
            Book(title: "The Chronicles of Narnia - The Lion, the Witch and the Wardrobe",
                 description: "The first book in C.S. Lewis's classic fantasy series, where four siblings discover a magical world through a wardrobe",
                 author: "C.S. Lewis",
                 publisher: "Geoffrey Bles",
                 year: 1950,
                 genre: "Fantasy",
                 isbn: "9780007115617",
                 isTaken: false),
            Book(title: "The Hitchhiker's Guide to the Galaxy",
                 description: "Follows the misadventures of Arthur Dent as he travels through space after the Earth is destroyed to make way for an interstellar highway",
                 author: "Douglas Adams",
                 publisher: "Pan Books",
                 year: 1979,
                 genre: "Science Fiction, Comedy",
                 isbn: "9780345391803",
                 isTaken: false)
        ]
        try await sampleBooks.create(on: self.app.db)

        try await self.app.test(.GET, "books", afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(
                try res.content.decode([BookDTO].self),
                sampleBooks.map { $0.toDTO() }
            )
        })
    }

    func testBookCreate() async throws {
        let newDTO = BookDTO(id: UUID(),
                             title: "The Hitchhiker's Guide to the Galaxy",
                             description: "Follows the misadventures of Arthur Dent as he travels through space after the Earth is destroyed to make way for an interstellar highway",
                             author: "Douglas Adams",
                             publisher: "Pan Books",
                             year: 1979,
                             genre: "Science Fiction, Comedy",
                             isbn: "9780345391803",
                             returningDeadline: Date(),
                             isTaken: false)

        try await self.app.test(.POST, "books", beforeRequest: { req in
            try req.content.encode(newDTO)
        }, afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            let models = try await Book.query(on: self.app.db).all()
            XCTAssertEqual(models.map { $0.toDTO().title }, [newDTO.title])
        })
    }

    func testBookRead() async throws {
        let uuid = UUID()
        let sampleBooks = [
            Book(id: uuid,
                 title: "The Chronicles of Narnia - The Lion, the Witch and the Wardrobe",
                 description: "The first book in C.S. Lewis's classic fantasy series, where four siblings discover a magical world through a wardrobe",
                 author: "C.S. Lewis",
                 publisher: "Geoffrey Bles",
                 year: 1950,
                 genre: "Fantasy",
                 isbn: "9780007115617",
                 isTaken: false),
            Book(title: "The Hitchhiker's Guide to the Galaxy",
                 description: "Follows the misadventures of Arthur Dent as he travels through space after the Earth is destroyed to make way for an interstellar highway",
                 author: "Douglas Adams",
                 publisher: "Pan Books",
                 year: 1979,
                 genre: "Science Fiction, Comedy",
                 isbn: "9780345391803",
                 isTaken: false)
        ]
        try await sampleBooks.create(on: self.app.db)

        try await self.app.test(.GET, "books/\(uuid.uuidString)", afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(
                try res.content.decode(BookDTO.self),
                sampleBooks[0].toDTO()
            )
        })
    }

    func testBookUpdate() async throws {
        let uuid = UUID()
        let sampleBooks = [
            Book(id: uuid,
                 title: "The Chronicles of Narnia - The Lion, the Witch and the Wardrobe",
                 description: "The first book in C.S. Lewis's classic fantasy series, where four siblings discover a magical world through a wardrobe",
                 author: "C.S. Lewis",
                 publisher: "Geoffrey Bles",
                 year: 1950,
                 genre: "Fantasy",
                 isbn: "9780007115617",
                 isTaken: false)
        ]
        try await sampleBooks.create(on: self.app.db)

        let newBook = BookDTO(id: nil,
                              title: "The Hitchhiker's Guide to the Galaxy",
                              description: "Follows the misadventures of Arthur Dent as he travels through  space after the Earth is destroyed to make way for an interstellar highway",
                              author: "Douglas Adams",
                              publisher: "Pan Books",
                              year: 1979,
                              genre: "Science Fiction, Comedy",
                              isbn: "9780345391803",
                              returningDeadline: nil,
                              isTaken: false)

        try await self.app.test(.PUT, "books/\(uuid)", beforeRequest: { req in
            try req.content.encode(newBook)
        }, afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            let model = try await Book.find(sampleBooks[0].id, on: self.app.db)
            XCTAssertEqual(model?.toDTO().title, newBook.title)
            XCTAssertEqual(model?.toDTO().description, newBook.description)
            XCTAssertEqual(model?.toDTO().author, newBook.author)
            XCTAssertEqual(model?.toDTO().publisher, newBook.publisher)
            XCTAssertEqual(model?.toDTO().year, newBook.year)
            XCTAssertEqual(model?.toDTO().isbn, newBook.isbn)
            XCTAssertEqual(model?.toDTO().returningDeadline, newBook.returningDeadline)
            XCTAssertEqual(model?.toDTO().isTaken, newBook.isTaken)
        })
    }

    func testBookDelete() async throws {
        let testBooks = [
            Book(title: "The Chronicles of Narnia - The Lion, the Witch and the Wardrobe",
                 description: "The first book in C.S. Lewis's classic fantasy series, where four siblings discover a magical world through a wardrobe",
                 author: "C.S. Lewis",
                 publisher: "Geoffrey Bles",
                 year: 1950,
                 genre: "Fantasy",
                 isbn: "9780007115617",
                 isTaken: false),
            Book(title: "The Hitchhiker's Guide to the Galaxy",
                 description: "Follows the misadventures of Arthur Dent as he travels through space after the Earth is destroyed to make way for an interstellar highway",
                 author: "Douglas Adams",
                 publisher: "Pan Books",
                 year: 1979,
                 genre: "Science Fiction, Comedy",
                 isbn: "9780345391803",
                 isTaken: false)
        ]
        try await testBooks.create(on: app.db)

        try await self.app.test(.DELETE, "books/\(testBooks[0].requireID())", afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            let model = try await Book.find(testBooks[0].id, on: self.app.db)
            XCTAssertNil(model)
        })
    }
}

extension BookDTO: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.author == rhs.author &&
        lhs.publisher == rhs.publisher &&
        lhs.year == rhs.year &&
        lhs.isbn == rhs.isbn &&
        lhs.returningDeadline == rhs.returningDeadline &&
        lhs.isTaken == rhs.isTaken
    }
}
