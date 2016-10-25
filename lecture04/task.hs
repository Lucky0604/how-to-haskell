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