-- check the type about the value
['a', 'b', 'c']
-- ['a', 'b', 'c'] :: [Char]
('a', 'b', 'c')
-- ('a', 'b', 'c') :: (Char, Char, Char)
[(False, '0'), (True, '1')]
-- [(False, '0'), (True, '1')] :: [(Bool, Char)]
([False, True], ['0', '1'])
-- ([False, True], ['0', '1']) :: ([Bool], [Char])
[tail, init, reverse]
-- [tail, init, reverse] :: [[a] -> [a]]


-- check the type about the function
second xs = head (tail xs)
-- second :: [a] -> a
swap (x, y) = (y, x)
-- swap :: (t1, t) -> (t, t1)
pair x y = (x, y)
-- pair :: t -> t1 -> (t, t1)
double x = x * 2
-- double :: Num a => a -> a
palindrome xs = reverse xs == xs
-- palindrome :: Eq a => [a] -> Bool
twice f x = f (f x)
-- twice :: (t -> t) -> t -> t