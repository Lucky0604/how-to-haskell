data BookInfo = Book Int String [String]
                deriving (Show)

type CustomerID = Int
type ReviewBody = String

data BetterReview = BetterReview BookInfo CustomerID ReviewBody

type BookRecord = (BookInfo, BetterReview)


-- | pattern match on an algebraic data type using its value constructors
bookID (Book id title authors) = id
bookTitle (Book id title authors) = title
bookAuthors (Book id title authors) = authors