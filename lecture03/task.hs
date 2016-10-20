-- slice a list
-- halve :: [a] -> ([a], [a])

-- use expression define the '&&' operator
(&&&) :: Bool -> Bool -> Bool
(&&&) a b = if a then b else False


-- using lambda expression replace the expression
mult :: Num a => a -> a -> a -> a
mult x y z = x * y * z
-- lambda expression
mult' :: Num a => a -> a -> a -> a
mult' = \x -> \y -> \z -> x * y * z

{-
create functions as short as possible
-}

{-
task:
The output of skips is a list of lists. The first list in the output should
be the same as the input list. The second list in the output should
contain every second element from the input list. . . and the nth list in
the output should contain every nth element from the input list.

example output:
skips "ABCD" = ["ABCD", "BD", "C", "D"]
skips "hello!" = ["hello!", "el!", "l!", "l", "!"]
skips [True, False] = [[True, False], [False]]
skips [] = []
skips [1] = [[1]]
-}
skips :: [a] -> [[a]]
-- | readable version
skips xs = [each i xs | i <- [1..length xs]]
-- | helper function
-- | Return each n-th element of the list
-- -> each 2 [1,2,3,4] = [2,4]
-- -> each 2 [] = []
each :: Int -> [a] -> [a]
each n xs = [xs !! i | i <- [n-1, n-1+n..length xs -1]]

-- | complicated
skips' :: [a] -> [[a]]
skips' xs =
  map (map fst . flip everyN xs) [1..length xs]
  where
    withIndexes = flip zip [1..]
    everyN n = filter (\(x, i) -> i `mod` n == 0) . withIndexes

-- | another complicated version
skip :: Int -> [a] -> [a]
skip n = map snd . filter (\x -> mod (fst x) n == 0) . zip [1..]

skips'' :: [a] -> [[a]]
skips'' xs = zipWith ($) (map skip [1..]) $ replicate (length xs) xs


-- | local maximum
{-
A local maximum of a list is an element of the list which is strictly
greater than both the elements immediately before and after it. For
example, in the list [2,3,4,1,5], the only local maximum is 4, since
it is greater than the elements immediately before and after it (3 and
1). 5 is not a local maximum since there is no element that comes
after it
-}
localMaxima :: [Integer] -> [Integer]
localMaxima (x:y:z:zs)
  | x < y && y > z = y : localMaxima(y: z: zs)
  | otherwise = localMaxima (y: z: zs)
localMaxima _ = []
