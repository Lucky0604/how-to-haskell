{-
Functor: basically for things that can be mapped over. 
-}

class Functor f where
  fmap :: (a -> b) -> f a -> f b

-- | map is just a fmap that works only on lists.
instance Functor [] where
  fmap = map

{-
Types that can act like a box can be functors.
You can think of a list as a box that has an infinite amount of little compartments and they can all be empty,
one can be full and the others empty or a number of them can be full.
-}

------------------

{-
 the Maybe a type. In a way,
it's like a box that can either hold nothing,
in which case it has the value of Nothing, or it can hold one item,
like "HAHA", in which case it has a value of Just "HAHA".
-}
instance Functor Maybe where
  fmap f (Just x) = Just (f x)
  fmap f Nothing = Nothing

{-
Tree type
-}
instance Functor Tree where
  fmap f EmptyTree = EmptyTree
  fmap f (Node x leftsub rightsub) = Node (f x) (fmap f leftsub) (fmap f rightsub)
  

{-
The Functor typeclass wants a type constructor that takes only one type parameter but `Either` takes two
partially apply Either by feeding it only one parameter so that it has one free parameter

-}
instance Functor (Either a) where
  fmap f (Right x) = Right (f x)
  fmap f (Left x) = Left x
