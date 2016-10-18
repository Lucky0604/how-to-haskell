-- | Parameterised types

{- 
 defines a type named Maybe: we can use this to represent a value 
 that could be either present or missing, e.g. a field in a database row that could be null.
 -}
data Maybe a = Just a
             | Nothing

someBool = Just True
someString = Just "something"

-- | nest uses of parameterised types inside each other
wrapped = Just (Just "wrapped")