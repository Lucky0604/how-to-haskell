module Fold_func where
import Prelude hiding ((.))
{-
We'd introduce the x:xs pattern and then we'd do some action that involves a single element and the rest of the list.
It turns out this is a very common pattern, so a couple of very useful functions were introduced to encapsulate it.
These functions are called folds. They're sort of like the map function, only they reduce the list to some single value


A fold takes a binary function, a starting value (I like to call it the accumulator)
and a list to fold up. The binary function itself takes two parameters.
The binary function is called with the accumulator and
the first (or last) element and produces a new accumulator.
Then, the binary function is called again with the new accumulator and the now new first (or last) element,
and so on. Once we've walked over the whole list, only the accumulator remains, which is what we've reduced the list to.
-}

-- | left fold, folds the list up from the left side
-- | foldl function
-- | rewrite sum func using foldl
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

-- | implementation ever more succinctly
sum'' :: (Num a) => [a] -> a
sum'' = foldl (+) 0
-- | The lambda function (\acc x -> acc + x) is the same as (+)


-- | implementation elem func using foldl
elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys

-- | The right fold, foldr works in a similar way to the left fold, only the accumulator eats up the values from the right
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs

{- Folds can be used to implement any function where you traverse a list once,
element by element, and then return something based on that.
Whenever you want to traverse a list to return something, chances are you want a fold
-}

-- | implement standard funcs by using folds
maximum' :: (Ord a) => [a] -> a
maximum' = foldr1 (\x acc -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = foldl (\acc x -> x : acc) []

product' :: (Num a) => [a] -> a
product' = foldr1 (*)

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x acc -> if p x then x : acc else acc) []

head' :: [a] -> a
head' = foldr1 (\x _ -> x)

last' :: [a] -> a
last' = foldl1 (\_ x -> x)


{-
Function Composition
-}
(.) :: (b -> c) -> (a -> b) -> a -> c
(.) f g = \x -> f (g x)
-- | f must take as its parameter a value that has the same type as g's return value.
-- | So the resulting function takes a parameter of the same type that g takes and returns a value of the same type that f returns

-- | point free style by using function composition
fn' x = ceiling (negate (tan (cos (max 50 x))))
-- | rewrite
fn'' = ceiling . negate . tan . cos . max 50

oddSquareSum :: Integer
oddSquareSum = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))
-- | rewrite
oddSquareSum' :: Integer
oddSquareSum' = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]

-- | better choice
oddSquareSum'' :: Integer
oddSquareSum'' =
  let oddSquares = filter odd $ map (^2) [1..]
      belowLimit = takeWhile (<10000) oddSquares
  in sum belowLimit
-- | more readable
