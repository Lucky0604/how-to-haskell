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


