-- | High Order function thinking

-- | implement zipWith function by curry func
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x : xs) (y : ys) = f x y : zipWith' f xs ys

-- | implement flip func
flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
  where
    g x y = f y x
-- | (a -> b -> c) -> (b -> a -> c) is the same as (a -> b -> c) -> (b -> (a -> c)) which is the same as
-- | (a -> b -> c) -> b -> a -> c
-- | so rewrite the function
flip'' :: (a -> b -> c) -> b -> a -> c
flip'' f y x = f x y

-- | use filter rewrite quicksort
quicksort :: (Ord a) => [a] -> [a]    
quicksort [] = []    
quicksort (x:xs) =     
    let smallerSorted = quicksort (filter (<=x) xs)  
        biggerSorted = quicksort (filter (>x) xs)   
    in  smallerSorted ++ [x] ++ biggerSorted  


-- |  find the largest number under 100,000 that's divisible by 3829
largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [10000, 9999..])
	where p x = x `mod` 3829 == 0


-- | find the sum of all odd squares that are smaller than 10,000
-- | use takeWhile func
-- | applied to a predicate p and a list xs, returns the longest prefix (possibly empty) of xs of elements that satisfy p
-- | takeWhile (> 3) [1,2,3,4] == []
-- | takeWhile (> 3) [4,5,2,6] == [4, 5]
-- | sum (takeWhile (< 10000) (filter odd (map (^2) [1..])))

-- | the same as
-- | sum (takeWhile (< 10000) [n^2 | n <- [1..], odd (n^2)])


{-
Collatz sequences
-- >  take a natural number. If that number is even, we divide it by two. If it's odd, we multiply it by 3 and then add 1 to that.
-}
chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
	| even n = n : chain (n `div` 2)
	| odd n = n : chain (n*3 + 1)

-- | for all starting numbers between 1 and 100, how many chains have a length greater than 15
numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..10]))
	where isLong xs = length xs > 15
