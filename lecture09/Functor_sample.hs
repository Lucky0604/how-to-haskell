module Functor_sample where

myfst :: (Int, Char) -> Int
myfst (x, y) = x

-- | 用类型参数代替实际类型，要求用户给出这个类型
myfst' :: (a, b) -> a
myfst' (x, y) = x


-- | 代数数据类型定义二叉树
data MyTree a = Leaf a
              | Node a (MyTree a) (MyTree a)
              deriving (Show)

-- | 利用递归和模式匹配定义获取最左侧叶子节点数据的函数
leftMost :: MyTree a -> a
leftMost (Leaf a) = a
leftMost (Node _ l r) = leftMost l


-- | 对MyTree a的每个节点的数据做一个运算得到另一个MyTree
myMap :: (a -> b) -> MyTree a -> MyTree b
myMap f (Leaf x) = Leaf (f x)
myMap f (Node x l r) = Node (f x) (myMap f l) (myMap f r)
