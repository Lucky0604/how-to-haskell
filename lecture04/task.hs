module Task where
-- | 在ide中运行代码可以添加main函数用以执行

{-
import Data.Char


main :: IO ()

lowers' :: String -> Int
lowers' xs = length [x | x <- xs, isLower x]

{-
如果x^2 + y ^ 2 = z ^ 2
,那么整数的三元元组(x,y,z)为一组勾股数。使用列表内包定义函数
pyths :: Int -> [(Int,Int,Int)],当给定一个上限的时候会返回小于它的所有勾股数。
-}
pyths :: Int -> [(Int, Int, Int)]
pyths n = [(x, y, z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]

main = do
  print (zip [1..10] ['a'..])

  -- | 使用列表内包,定义一个表达式来计算,1 到 100 之间各个数平方之和
  print(sum [x * x | x <- [1..100]])
  print(pyths 10)
  print ("Hello")
  print (lowers' "ahHh")
-}

import Data.List

{-
task 1

reimplement each function more idiomatic Haskell style by using wholemeal programming
-}
fun1 :: [Integer] -> Integer
fun1 [] = 1
fun1 (x : xs)
	| even x = (x - 2) * fun1 xs
	| otherwise = fun1 xs

fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n | even n = n + fun2 (n `div` 2)
			 | otherwise = fun2 (3 * n + 1)

-- | reimplement fun1
fun1' :: [Integer] -> Integer
fun1' = product . map (\x -> x - 2) . filter even

fun1''' :: [Integer] -> Integer
fun1''' = foldr (\x y -> if even x then (x - 2) * y else y) 1

-- | reimplement fun2
fun2' :: Integer -> Integer
fun2' = sum . filter even . takeWhile (/= 1) . iterate (\n -> if even n then n `div` 2 else 3 * n + 1)

{-
task 2
Folding with trees
-}
{-
 one sample output might be the following
foldTree "ABCDEFGHIJ" ==
	Node 3
		(Node 2
		(Node 0 Leaf ’F’ Leaf)
		’I’
		(Node 1 (Node 0 Leaf ’B’ Leaf) ’C’ Leaf))
	’J’
		(Node 2
		(Node 1 (Node 0 Leaf ’A’ Leaf) ’G’ Leaf)
		’H’
		(Node 1 (Node 0 Leaf ’D’ Leaf) ’E’ Leaf))
-}
data Tree a = Leaf
						| Node Integer (Tree a) a (Tree a)
	deriving (Show, Eq)

foldTree :: [a] -> Tree a
foldTree = foldr insertNode Leaf

insertNode :: a -> Tree a -> Tree a
insertNode x Leaf = Node 0 Leaf x Leaf
insertNode x (Node h ln y rn)
	| treeHeight ln < treeHeight rn =
		let nn = insertNode x ln
		in Node (treeHeight nn + 1) nn y rn
	| otherwise =
		let nn = insertNode x rn
		in Node (treeHeight nn + 1) ln y nn

treeHeight :: Tree a -> Integer
treeHeight Leaf = -1
treeHeight (Node h _ _ _) = h


{-
Implement a function
xor :: [Bool] -> Bool
which returns True if and only if there are an odd number of True
values contained in the input list. It does not matter how many
False values the input list contains. For example,
xor [False, True, False] == True
xor [False, True, False, False, True] == False
Your solution must be implemented using a fold
-}
xor :: [Bool] -> Bool
xor = foldr xor' False
			where
				xor' True True = False
				xor' False False = False
				xor' _ _ = True

xor' :: [Bool] -> Bool
xor' = odd . length . filter id

xor'' :: [Bool] -> Bool
xor'' = foldr (\x y -> (not x && y) || (x && not y)) False

xor''' :: [Bool] -> Bool
xor''' = foldr xor2 False

xor2 :: Bool -> Bool -> Bool
xor2 a b = (a || b) && not (a && b)

{-
Implement map as a fold. That is, complete the definition
map’ :: (a -> b) -> [a] -> [b]
map’ f = foldr ...
in such a way that map’ behaves identically to the standard map
function.
-}
map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x y -> f x : y) []

map'' :: (a -> b) -> [a] -> [b]
map'' f = foldr g []
  	where
  		g x acc = f x : acc

{-
Implement foldl using foldr. That is, complete the
definition
myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f base xs = foldr ...
in such a way that myFoldl behaves identically to the standard
foldl function.
-}
myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f base xs = foldr (flip f) base (reverse xs)

-- | use `id`
myFoldl' :: (a -> b -> a) -> a -> [b] -> a
myFoldl' f base xs = foldr (\b g x = g (f x b)) id xs base