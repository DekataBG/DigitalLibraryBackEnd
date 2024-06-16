//
//  MockData.swift
//
//
//  Created by Desislav Adamov on 16.06.24.
//

import Foundation

struct BooksMockData {
    static let books: [Book] = [
        Book(title: "Harry Potter and the Philosopher's Stone",
             description: "Introduces readers to the young wizard Harry Potter and his adventures at Hogwarts School of Witchcraft and Wizardry",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 1997,
             genre: "Fantasy",
             isbn: "9780747532743",
             isTaken: false),
        Book(title: "Harry Potter and the Chamber of Secrets",
             description: "Follows Harry's second year at Hogwarts and the discovery of the Chamber of Secrets",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 1998,
             genre: "Fantasy",
             isbn: "9780747538493",
             isTaken: false),
        Book(title: "Harry Potter and the Prisoner of Azkaban",
             description: "Harry learns more about his past and encounters the dangerous prisoner Sirius Black",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 1999,
             genre: "Fantasy",
             isbn: "9780747546290",
             isTaken: false),
        Book(title: "Harry Potter and the Goblet of Fire",
             description: "Harry competes in the Triwizard Tournament, facing unexpected challenges and dangers",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 2000,
             genre: "Fantasy",
             isbn: "9780747546245",
             isTaken: false),
        Book(title: "Harry Potter and the Order of the Phoenix",
             description: "Harry faces challenges and uncovers dark secrets as he prepares for the looming threat of Lord Voldemort",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 2003,
             genre: "Fantasy",
             isbn: "9780747551003",
             isTaken: false),
        Book(title: "Harry Potter and the Half-Blood Prince",
             description: "Reveals the backstory of Lord Voldemort and Harry's final years at Hogwarts",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 2005,
             genre: "Fantasy",
             isbn: "9780747581086",
             isTaken: false),
        Book(title: "Harry Potter and the Deathly Hallows",
             description: "Follows Harry, Ron, and Hermione as they hunt for Horcruxes and face the final showdown against Lord Voldemort",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 2007,
             genre: "Fantasy",
             isbn: "9780747591054",
             isTaken: false),
        Book(title: "The Hobbit",
             description: "Follows the adventure of Bilbo Baggins as he accompanies a group of dwarves on a quest to reclaim their homeland from the dragon Smaug",
             author: "J.R.R. Tolkien",
             publisher: "George Allen & Unwin",
             year: 1937,
             genre: "Fantasy",
             isbn: "9780261102217",
             isTaken: false),
        Book(title: "To Kill a Mockingbird",
             description: "Explores racial injustice in the American South through the eyes of a young girl named Scout Finch",
             author: "Harper Lee",
             publisher: "J.B. Lippincott & Co.",
             year: 1960,
             genre: "Historical Fiction, Southern Gothic",
             isbn: "9780061120084",
             isTaken: false),
        Book(title: "1984",
             description: "A dystopian novel depicting a totalitarian regime and the struggles of its protagonist against oppressive government control",
             author: "George Orwell",
             publisher: "Secker & Warburg",
             year: 1949,
             genre: "Dystopian Fiction",
             isbn: "9780451524935",
             isTaken: false),
        Book(title: "The Great Gatsby",
             description: "Set in the Roaring Twenties, the novel explores themes of wealth, love, and the American Dream",
             author: "F. Scott Fitzgerald",
             publisher: "Charles Scribner's Sons",
             year: 1925,
             genre: "Classic, Jazz Age, Tragedy",
             isbn: "9780743273565",
             isTaken: false),
        Book(title: "Pride and Prejudice",
             description: "A classic novel by Jane Austen, focusing on the issues of love, class, and manners in early 19th-century England",
             author: "Jane Austen",
             publisher: "T. Egerton, Whitehall",
             year: 1813,
             genre: "Classic, Romance, Satire",
             isbn: "9780141439518",
             isTaken: false),
        Book(title: "One Hundred Years of Solitude",
             description: "A magical realist novel that chronicles the Buendía family over several generations in the fictional town of Macondo",
             author: "Gabriel García Márquez",
             publisher: "Editorial Sudamericana",
             year: 1967,
             genre: "Magical Realism",
             isbn: "9780060883287",
             isTaken: false),
        Book(title: "The Catcher in the Rye",
             description: "Follows the experiences of Holden Caulfield, a disenchanted teenager, during a few days in New York City",
             author: "J.D. Salinger",
             publisher: "Little, Brown and Company",
             year: 1951,
             genre: "Coming-of-Age, Bildungsroman",
             isbn: "9780316769488",
             isTaken: false),
        Book(title: "The Lord of the Rings",
             description: "A high-fantasy trilogy that follows the quest to destroy the One Ring and defeat the Dark Lord Sauron",
             author: "J.R.R. Tolkien",
             publisher: "George Allen & Unwin",
             year: 1954,
             genre: "High Fantasy, Epic Fantasy",
             isbn: "9780261102385",
             isTaken: false),
        Book(title: "Brave New World",
             description: "A dystopian novel that explores a future society where people are conditioned for conformity and pleasure",
             author: "Aldous Huxley",
             publisher: "Chatto & Windus",
             year: 1932,
             genre: "Dystopian Fiction",
             isbn: "9780060850524",
             isTaken: false),
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
             isTaken: false),
        Book(title: "The Hunger Games",
             description: "Set in a dystopian future where teenagers are forced to participate in a televised death match known as the Hunger Games",
             author: "Suzanne Collins",
             publisher: "Scholastic",
             year: 2008,
             genre: "Dystopian Fiction, Science Fiction",
             isbn: "9780439023481",
             isTaken: false),
        Book(title: "The Da Vinci Code",
             description: "A mystery thriller that follows symbologist Robert Langdon as he investigates a murder at the Louvre Museum and unravels a conspiracy",
             author: "Dan Brown",
             publisher: "Doubleday",
             year: 2003,
             genre: "Mystery, Thriller, Conspiracy Fiction",
             isbn: "9780307474278",
             isTaken: false),
        Book(title: "Clean Code",
             description: "Focuses on writing readable, maintainable, and efficient code by applying various programming principles and practices.",
             author: "Robert C. Martin",
             publisher: "Prentice Hall",
             year: 2008,
             genre: "Software Development",
             isbn: "9780132350884",
             isTaken: false),
        Book(title: "48 Laws of Power",
             description: "Explores the dynamics of power and offers timeless insights into human behavior, drawing examples from historical figures and events.",
             author: "Robert Greene",
             publisher: "Viking Press",
             year: 1998,
             genre: "Self-help",
             isbn: "9789542831426",
             isTaken: false)
    ]
}
