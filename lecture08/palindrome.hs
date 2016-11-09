module Palindrome where

{-
make a program that continuously reads a line
and then tells us if the line is a palindrome or not.
We could just use getLine to read a line, tell the user if it's a palindrome and then run main all over again.

When using interact, think about what you need
to do to transform some input into the desired output.
In our case, we have to replace each line of the input with either "palindrome" or "not a palindrome".
So we have to write a function that transforms something
like "elephant\nABCBA\nwhatever" into "not a palindrome\npalindrome\nnot a palindrome"
-}
main = interact respondPalindromes

{-
respondPalindromes contents = unlines (map (\xs ->
                                              if isPalindrome xs then "palindrome" else "not a palindrome") (lines contents))
                              where
                                isPalindrome xs = xs == reverse xs
-}

-- | rewrite this in point-free
respondPalindromes = unlines . map (\xs ->
                                      if isPalindrome xs then "palindrome" else "not a palindrome") . lines
                     where
                       isPalindrome xs = xs == reverse xs

