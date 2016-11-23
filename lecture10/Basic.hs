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


-- | Lists (actually the list type constructor []) are applicative functors
instance Applicative [] where
  pure x = [x]
  fs <*> xs = [f x | f <- fs, x <- xs]


-- | another instance of Applicative is `IO`
instance Applicative IO where
  pure = return
  a <*> b = do
    f <- a
    x <- b
    return (f x)

{-
<*> were specialized for IO it would have a type of (<*>) :: IO (a -> b) -> IO a -> IO b

It would take an I/O action that yields a function as its result and another I/O action
and create a new I/O action from those two that, when performed,
first performs the first one to get the function and then performs the
second one to get the value and then it would yield that function applied to the value as its result.
We used do syntax to implement it here.
-}
myAction :: IO String
myAction = do
  a <- getLine
  b <- getLine
  return $ a ++ b

-- | Another way of writing this would be to use the applicative style.
myAction' :: IO String
myAction' = (++) <$> getLine <*> getLine

{-
The type of the expression (++) <$> getLine <*> getLine is IO String,
which means that this expression is a completely normal I/O action like any other,
which also holds a result value inside it, just like other I/O actions
-}
main = do
  a <- (++) <$> getLine <*> getLine
  putStrLn $ "The two lines concatenated turn out to be : " ++ a


-- | another instance of `Applicative` is `(->) r`
instance Applicative ((->) r) where
  pure x = (\_ -> x)
  f <*> g = \x -> f x (g x)


