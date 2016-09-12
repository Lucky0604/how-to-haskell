import Data.Char

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


-- | --------------------------------------------------------------------------------------------
-- | 字符串内包

-- | 返回小写字母个数
lowers' :: String -> Int
lowers' xs = length [x | x <- xs, isLower x]

-- | 特定字符在字符串中出现次数
count' :: Char -> String -> Int
count' x xs = length [x' | x' <- xs, x == x']

-- | -----------------------------------------------------------------------------------------------
{-
为了编码一个字符串,凯撒将字符串的每个字母用它所在字母表位置后查 3 位所得的字母代替,
对于字母表末尾的字母在后查 3 位时会跳回到开头,这样就形成了一个圈
"Haskell is fun" -> "kdvnhoo lv ixq"
-}

-- | 编码
{-
简化问题,仅仅编码小写字母组成的字符串,其他的字符如大写字母与标点保持不变。
首先来定义一个函数 let2int,它可以把小写 ‘a’到 ‘z’间的字母转化为 0 到 25 的数字,
再定义一个函数 int2let 可以执行相反的操作
-}
let2int :: Char -> Int
let2int c = ord c - ord 'a'

int2let :: Int -> Char
int2let n = chr (ord 'a' + n)

{-
使用这两个函数,我们可以定义一个函数shift,它可以将一个小写字母移动给定的位数,
通过将字母转化为对应的整数,加上移动的位数,取得除以 26 所得的余数,最后转化为对应
的小写字母就可以了
-}
shift' :: Int -> Char -> Char
shift' n c | isLower c = int2let ((let2int c + n) `mod` 26)
           | otherwise = c

{-
在一个字符串内包表达式中使用想 shift 函数,可以定义一个函数 encode 来将一
个字符串使用给定的移动位数进行编码了
-}
encode :: Int -> String -> String
encode n xs = [shift' n x | x <- xs]

{-
 频率表
-}
table :: [Float]
table = [8.2, 1.5, 6.1, 7.0,
         7.5, 1.9, 1.0, 2.4,
         2.8, 0.2, 0.1, 0.2,
         4.3, 0.8, 6.0, 2.0,
         12.7, 2.2, 2.0, 4.0,
				 2.4, 6.7, 6.3, 9.1,
				 2.8, 0.1]


-- | 定义一个函数来计算两个整数相除所得的小数
percent :: Int -> Int -> Float
percent n m = (fromIntegral n / fromIntegral m) * 100

{-
在字符串内包中使用 percent 跟前一节中定义的 lowers 与 count 函数,我们就可以定义一个函数来
返回任意字符串的频率表了
-}
freqs :: String -> [Float]
freqs xs = [percent (count' x xs) n | x <- ['a'..'z']]
            where n = lowers' xs

-- | 解密

-- | 卡方统计
-- | 使用库函数zip与列表内包，将卡方统计数学公式翻译：
chisqr :: [Float] -> [Float] -> [Float]
chisqr os es = sum [((o - e) ^ 2) / e | (o, e) <- zip os es]

{-
定义一个函数来将一个列表的元素向左翻转 n 位,将列表开始的元素放于列表的
末尾,假定 n 的值介于 0 与列表长度之间:
-}
rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs

crack :: String -> String
crack xs = encode (-factor) xs
          where
          	factor = head (positions (minimum chitab) chitab)
						chitab = [chisqr (rotate n table') table | n <- [0..25]]
						table' = freqs xs
