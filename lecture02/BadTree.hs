-- | Incorrectly trying to compare for equality


-- | if we want to compare the values stored in two nodes of type Tree, and return one of them if they're equal
bad_nodesAreSame (Node a _ _) (Node a _ _) = Just a
bad_nodesAreSame _ _ = Nothing
{-
 - A name can only appear once in a set of pattern bindings. 
 - We cannot place a variable in multiple positions to express the notion “this value and that should be identical”. 
 - Instead, we'll solve this problem using guards, another invaluable Haskell feature.
 - -}


-- | Conditional evaluation with guards
nodesAreSame (Node a _ _) (Node b _ _)
    | a = b == Just a
nodesAreSame _ _ = Nothing
