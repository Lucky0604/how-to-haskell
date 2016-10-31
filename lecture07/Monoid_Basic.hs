module Monoid_Basic where

{-
A monoid is when you have an associative binary function 
and a value which acts as an identity with respect to that function. 
When something acts as an identity with respect to a function, 
it means that when called with that function and some other value, 
the result is always equal to that other value
-}

-- | see how the type class is defined
class Monoid m where
	mempty :: m
	mappend :: m -> m -> m
	mconcat :: [m] -> m
	mconcat = foldr mappend mempty

-- | make sure they follow these laws
{-
The function takes two parameters.
The parameters and the returned value have the same type.
There exists such a value that doesn't change other values when used with the binary function.
-}
-- | mempty `mappend` x = x
-- | x `mappend` mempty = x
-- | (x `mappend` y) `mappend` z = x `mappend` (y `mappend` z)


-- | --------------------------------------------------------------
-- | Lists are monoids

-- | the ++ function and the empty list [] form a monoind
instance Monoid [a] where
	mempty = []
	mappend = (++)

{-
notice : 
wrote instance Monoid [a] and not instance Monoid [], because Monoid requires a concrete type for an instance.
-}


-- | Product and Sum
newtype Product a = Product {getProduct :: a}
	deriving (Eq, Ord, Read, Show, Bounded)

-- | just a newtype wrapper with one type parameter along with some derived instances. Its instance for Monoid goes a little something like this:
instance Num a => Monoid (Product a) where
	mempty = Product 1
	Product x `mappend` Product y = Product (x * y)
-- | Sum is the same as Product


-- | Any and All
newtype Any = Any { getAny :: Bool } deriving (Eq, Show, Ord, Read, Bounded)

-- | the Any's instance looks like
instance Monoid Any where
	mempty = Any False
	Any x `mappend` Any y = Any (x || y)

newtype All = All { getAll :: Bool } deriving (Eq, Show, Ord, Read, Bounded)

-- | the instance looks like this
instance Monoid All where
	mempty = All True
	All x `mappend` All x = All (x && y)














