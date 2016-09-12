-- | 在ide中运行代码可以添加main函数用以执行
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
