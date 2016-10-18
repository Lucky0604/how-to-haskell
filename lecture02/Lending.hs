-- | local variable

{-
Within the body of a function, we can introduce new local variables whenever we need them, using a let expression
-}


-- | determines whether we should lend some money to a customer. We meet a money reserve of at least 100, we return our new balance after subtracting the amount we have loaned.
lend mount balance = let reverse = 100
                         newBalance = balance - mount
                     in if balance < reverse
                           then Nothing
                           else Just newBalance


-- | a similar function to lend, using where instead of let
lend2 mount balance = if mount < reverse * 0.5
                         then Just newBalance
                         else Nothing
  where reverse = 100
        newBalance = balance - mount
