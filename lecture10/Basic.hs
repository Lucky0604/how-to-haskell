-- | Applicative Functor
{-
it defines two methods, pure and <*>
It doesn't provide a default implementation for any of them
have to define them both if we want something to be an applicative functor.
-}

import Control.Applicative

class (Functor t) => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
{-
fmap :: (a -> b) -> f a -> f b
It's a sort of a beefed up fmap.
Whereas fmap takes a function and a functor and applies the function inside the functor,

<*> takes a functor that has a function in it and another functor
and sort of extracts that function from the first functor and then maps it over the second one
-}

-- | Applicative instance implementation for Maybe
instance Applicative Maybe where
  pure = Just
  Nothing <*> _ = Nothing
  (Just f) <*> something = fmap f something


-- | --------------------------------------------------------

{-
pure f <*> x equals fmap f x
one of the applicative laws
-}

-- | <$>, which is just fmap as an infix operator
(<$>) :: (Functor f) => (a -> b) -> f a -> f b
f <$> x = fmap f x
