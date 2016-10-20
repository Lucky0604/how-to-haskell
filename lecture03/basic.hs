-- tuple style
fst' :: (a, b) -> a
fst' (x, _) = x

-- lambda expression

add' x y = x + y
-- replace with lambda
add'' = \x -> \y -> x + y

const' :: a -> b -> a
const' x _ = x
-- replace with lambda
const'' :: a -> (b -> a)
const'' x = \_ -> x

odds' :: Int -> [Int]
odds' n = map f [0..n-1]
            where f x = x * 2 + 1
-- replace with lambda
odds'' :: Int -> [Int]
odds'' n = map (\x -> 2 * x + 1) [0..n-1]

{-
Recursion patterns
-}

-- | Map

-- | simple definition of lists of Int value
data IntList = Empty | Cons Int IntList
  deriving Show

-- |  we could ensure that every element in a list is nonnegative by taking the absolute value:
absAll :: IntList -> IntList
absAll Empty = Empty
absAll (Cons x xs) = Cons (abs x) (absAll xs)

-- | square every element
squareAll :: IntList -> IntList
squareAll Empty = Empty
squareAll (Cons x xs) = Cons (x * x) (squareAll xs)


-- | Filter
-- |  keep only the positive numbers, Or only the even ones
keepOnlyEven :: IntList -> IntList
keepOnlyEven Empty = Empty
keepOnlyEven (Cons x xs)
  | even x = Cons x (keepOnlyEven xs)
  | otherwise = keepOnlyEven xs

-- | ------------------------------------------------------------------

-- | Polymorphism

-- | polymorphic data type
-- | E for Empty, C for Cons
data List t = E | C t (List t)
-- | t is a type variable
lst1 :: List Int
lst1 = C 3 (C 5 ( C 2 E))

lst2 :: List Char
lst2 = C 'x' (C 'y' (C 'z' E))

lst3 :: List Bool
lst3 = C True (C False E)

-- | generalize filterIntList to work over the new polymorphic Lists
-- | replace Empty by E and Cons by C:
filterList _ E = E
filterList p (C x xs)
  | p x = C x (filterList p xs)
  | otherwise = filterList p xs

-- | mapList
-- | general
mapList :: (t -> t) -> List t -> List t
-- | it means that when applying mapList, we always get a list with the same type of elements as the list we started with.

-- | better
mapList :: (a -> b) -> List a -> List b
mapList _ E = E
mapList f (C x xs) = C (f x) (mapList f xs)
-- | polymorphic functions is that the caller gets to pick the types. When you write a polymorphic function, it must work for every possible input type
