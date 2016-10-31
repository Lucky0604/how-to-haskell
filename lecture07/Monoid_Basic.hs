module Monoid_Basic where

import Data.Monoid

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