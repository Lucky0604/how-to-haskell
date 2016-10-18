
-- | Recursive types

{-
The familiar list type is recursive: it's defined in terms of itself. 
To understand this, let's create our own list-like type. 
We'll use Cons in place of the (:) constructor, and Nil in place of []
-}
data List a = Cons a (List a)
            | Nil
              deriving (Show)

{-
write a function that takes any value of type [a], and produces a value of type List a
-}
fromList (x: xs) = Cons x (fromList xs)
fromList [] = Nil
