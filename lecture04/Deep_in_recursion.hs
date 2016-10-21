-- | Deep in Recursion

{-
定下一个边界条件， 即处理单个元素的 List 时， 回传该元素。 如果该 List 的头部大于尾
部的最大值， 我们就可以假定较长的 List 的最大值就是它的头部。 而尾部若存在比它更大的元素， 它就是尾部的最大值
-}
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x: xs)
  | x > maxTail = x
  | otherwise = maxTail
  where
    maxTail = maximum' xs

-- | 改用max函数
maximum'' :: (Ord a) => [a] -> a
maximum'' [] = error "maximum of empty list"
maximum'' [x] = x
maximum'' (x: xs) = max x (maximum'' xs)


{-
rewrite replicate function
-}
-- | 边界条件应为负数，如果要重复某元素0次，那就是空list，负数也一样
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
  | n <= 0 = []
  | otherwise = x : replicate' (n - 1) x

{-
rewrite take function
-}
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
  | n <= 0 = []
take' _ [] = []
take' n (x : xs) = x : take' (n - 1) xs

{-
rewrite reverse function
-}
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x : xs) = reverse' xs ++ [x]

{-
rewrite repeat function
-}
-- | Haskell 支持无限列表，因此可重写为
repeat' :: a -> [a]
repeat' x = x : repeat' x

{-
rewrite zip function
-}
-- | zip 取两个 List 作参数并将其捆在一起。 zip [1,2,3] [2,3] 回传 [(1,2),(2,3)] , 它会把较长的 List 从中间断开, 以匹配较短的 List
zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x: xs) (y: ys) = (x, y) : zip' xs ys
{-
前两个模式表示两个 List 中若存在空 List, 则回传空 List. 第三个模式表示将两个 List 捆绑的行为, 即将其头部配对并后跟捆绑
的尾部. 用 zip 处理 [1,2,3] 与 ['a','b'] 的话, 就会在 [3] 与 [] 时触及边界条件, 得到 (1,'a'):(2,'b'):[] 的结果,与
[(1,'a'),(2,'b')] 等价
-}


{-
rewrite elem function
-}
-- | 取一个元素与一个 List 作参数, 并检测该元素是否包含于此 List. 而边缘条件就与大多数情况相同, 空 List. 大家都知道空 List 中不包含任何元素, 便不必再做任何判断
elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x : xs)
  | a == x = True
  | otherwise = a `elem'` xs
-- | 若头部不是该元素, 就检测尾部, 若为空 List 就回传 False

-- | --------------------------------------------------------------------------------------------
-- | quick sort
-- | 排过序的 List 就是令所有小于等于头部的元素在先(它们已经排过了序), 后跟大于头部的元素(它们同样已经拍过了序)。
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x : xs) =
  let smallerSorted = quicksort [a | a <- xs, a <= x]
      biggerSorted = quicksort [a | a <- xs, a > x]
  in smallerSorted ++ [x] ++ biggerSorted
