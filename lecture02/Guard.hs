-- | case expression

{-
Function definitions are not the only place where we can use pattern matching. The case construct lets us match patterns within an expression
-}

-- | This function (defined for us in Data.Maybe) unwraps a Maybe value, using a default if the value is Nothing
fromMaybe defval wrapped =
  case wrapped of
    Nothing -> defval
    Just value -> value


-- | Conditional evaluation defined `myDrop` function
myDrop n xs = if n <= 0 || null xs
             then xs
             else myDrop (n - 1) (tail xs)

-- | reformulation that uses patterns and guards
niceDrop n xs | n <= 0 = xs
niceDrop _ [] = []
niceDrop n (_: xs) = niceDrop (n - 1) xs
