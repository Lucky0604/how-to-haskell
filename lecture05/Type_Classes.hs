module Type_Class where

{-
-- | detail at the Eq type class
class Eq a where
	(==) :: a -> a -> Bool
	(/=) :: a -> a -> Bool
-- | Eq is declared to be a type class with a single parameter, a.
-- | Any type a which wants to be an instance of Eq must define two functions, (==) and (/=), with the indicated type signatures. 
-}


-- |  make our own type and declare an instance of Eq for it.
data Foo = F Int | G Char

instance Eq Foo where
	(F i1) == (F i2) = i1 == i2
	(G c1) == (G c2) = c1 == c2
	_ == _ = False

	foo1 /= foo2 = not (foo1 == foo2)


{-
In fact, type classes can give default 
implementations of methods in terms of other methods, 
which should be used whenever an instance does not 
override the default definition with its own. 
So we could imagine declaring Eq like this:
-}
class Eq a where
	(==) :: a -> a -> Bool
	(/=) :: a -> a -> Bool
	x /= y = not (x == y)


{-
In fact, the Eq class is actually declared like this:
-}
class Eq a where
	(==), (/=) :: a -> a -> Bool
	x == y = not (x /= y)
	x /= y = not (x == y)


-- | ---------------------------------------------------------------------
-- | type class example
class Listable a where
	toList :: a -> [Int]
-- | We can think of Listable as the class of things which can be converted to a list of Ints.
-- | toList :: Listable a => a -> [Int]

-- | make some instances for Listable

-- | an Int can be converted to an [Int] just by creating a singleton list
instance Listable Int where
	-- toList :: Int -> [Int]
	toList x = [x]

-- | Bool can be converted similarly, say, by translating True to 1 and False to 0:
instance Listable Bool where
	toList True = [1]
	toList False = [0]

-- | We don’t need to do any work to convert a list of Int to a list of Int:
instance Listable [Int] where
	toList = id

-- | here’s a binary tree type which we can convert to a list by flattening:
data Tree a = Empty | Node a (Tree a) (Tree a)

instance Listable (Tree Int) where
	toList Empty = []
	toList (Node x l r) = toList l ++ [x] ++ toList r

-- | If we implement other functions in terms of toList, they also get a Listable constraint
sumL x = sum (toList x)
-- | sumL will work only for types which are instances of Listable, since it uses toList. 

foo x y = sum (toList x) == sum (toList y) || x < y
-- | $> foo :: (Listable a, Ord a) => a -> a -> Bool
-- |  foo works over types which are instances of both Listable and Ord, since it uses both toList and comparison on the arguments.

-- | more complex
instance (Listable a, Listable b) => Listable(a, b) where
	toList (x, y) = toList x ++ toList y
{-
 a pair type (a,b) is an instance of Listable as long as a and b both are. 
 Then we get to use toList on values of types a and b in our definition 
 of toList for a pair. Note that this definition is not recursive! 
 The version of toList that we are defining is calling other versions of toList, not itself.
-}