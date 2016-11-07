module Reversed_Words where

{-
main = do
  line <- getLine
  if null line
    then return ()
    else do
      putStrLn $ reverseWords line
      main

reverseWords :: String -> String
reverseWords = unwords . map reverse . words
-}

{-
In imperative languages, return usually ends the execution of a method or subroutine and makes it report some sort of value to whoever called it. In Haskell (in I/O actions specifically), it makes an I/O action out of a pure value
-}


{-
-- | putStr
main = do putStr "Hey, "
          putStr "I'm "
          putStr "Andy!"
-}


{-
-- | putChar
main = do putChar 't'
          putChar 'e'
          putChar 'h'
-}


{-
-- | putStr is actually defined recursively with the help of putChar
putStr :: String -> IO ()
putStr [] = return ()
putStr (x : xs) = do
  putChar x
  putStr xs
-}


{-
-- | print takes a value of any type that's an instance of Show (meaning that we know how to represent it as a string)
main = do print True
          print 2
          print "haha"
          print 3.2
          print [3,4,3]
-}


{-
-- | getChar
main = do
  c <- getChar
  if c /= ' '
    then do
      putChar c
      main
    else return ()
-}


{-
-- | rewrite using when func
import Control.Monad

main = do
  c <- getChar
  when (c /= ' ') $ do
    putChar c
    main
-}
{-
in a do block it looks like a control flow statement,
but it's actually a normal function.
It takes a boolean value and an I/O action if that boolean value is True,
it returns the same I/O action that we supplied to it. However,
if it's False, it returns the return (), action, so an I/O action that doesn't do anything
-}


{-
-- | sequence
{-
main = do
  a <- getLine
  b <- getLine
  c <- getLine
  print [a, b, c]
-}
-- | same as
main = do
  rs <- sequence [getLine, getLine, getLine]
  print rs
-}



-- | forM
-- |  it has its parameters switched around
-- | The first parameter is the list and the second one is the function to map over that list, which is then sequenced
import Control.Monad

main = do
  colors <- forM [1,2,3,4] (\a -> do
                               putStrLn $ "Which color do you associate with the number " ++ show a ++ "?"
                               color <- getLine
                               return color)
  putStrLn "The colors that you associate with 1, 2, 3 and 4 are: "
  mapM putStrLn colors
