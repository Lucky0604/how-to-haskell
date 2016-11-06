module Let_expression_IO where

import Data.Char

main = do
  putStrLn "Whats your first name?"
  firstName <- getLine
  putStrLn "What's your last name?"
  lastName <- getLine
  let bigFirstName = map toUpper firstName
      bigLastName = map toUpper lastName
  putStrLn $ "hey " ++ bigFirstName ++ " " ++ bigLastName ++ ", how are you?"
-- | <- is (for now) for performing I/O actions and binding their results to names
-- | map toUpper firstName, however, isn't an I/O action. It's a pure expression in Haskell

{-
 So use <- when you want to bind results of I/O actions to names and you can use let bindings to bind pure expressions to names
-}
