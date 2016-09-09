{-
	list generator
-}

-- 将一个列表中的列表连接起来，通过用一个生成器依次选取每一个列表，再用另一个生成器选择每一个元素
concat' :: [[a]] -> [a]
concat' xss = [x | xs <- xss, x <- xs]

-- get the first item from a tuple list
first' :: [(a, b)] -> [a]
first' ps = [x | (x, _) <- ps]

-- `length` replace the element to 1 and then sum the list
length' :: [a] -> Int
length' xs = sum [1 | _ <- xs]


{-
	guard
-}
factors' :: Int -> [Int]
factors' n = [x | x <- [1..n], n `mod` x == 0]

-- check if it is a prime num
prime' :: Int -> Bool
prime' n = factors' n == [1, n]

-- generate all prime num less than `n` that be given
primes' :: Int -> [Int]
primes' n = [x | x <- [2..n], prime' x]

find' :: Eq a => a -> [(a, b)] -> [b]
find' k t = [v | (k', v) <- t, k == k']


-- | --------------------------------------------------------------------------------
-- | zip 函数
-- zip ['a', 'b', 'c'] [1, 2, 3, 4]
-- [('a', 1), ('b', 2), ('c', 3)]

-- | 定义一个函数pair，返回一个列表中相邻元素所组成的二元元组
pairs' :: [a] -> [(a, a)]
pairs' xs = zip xs (tail xs)

-- | 判定一个列表是否已排好序的函数，需要检查任意相邻的元素是不是升序的即可
sorted' :: Ord a => [a] -> Bool
sorted' xs = and [x <= y | (x, y) <- pairs' xs]

-- | 通过把元素与其所在位置配对，选择出想要的元素的位置
positions :: Eq a => a -> [a] -> [Int]
positions x xs = [i | (x', i) <- zip xs [0..n], x == x']
									where n = length xs - 1
