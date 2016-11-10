module Write_File where

{-
writeFile has a type of writeFile :: FilePath -> String -> IO ().
It takes a path to a file and a string to write to that file and returns
an I/O action that will do the writing.
If such a file already exists, it will be stomped down to zero length before being written on.
-}

import System.IO
import Data.Char

{-
main = do
  contents <- readFile "girlfriends.txt"
  writeFile "girlfriendscaps.txt" (map toUpper contents)
-}


-- | appendFile
{-
appendFile has a type signature that's just like writeFile, only appendFile
doesn't truncate the file to zero length if it already exists but it appends stuff to it.
-}
{-
main = do
  todoItem <- getLine
  appendFile "todo.txt" (todoItem ++ "\n")
-}


-- | I/O lazy
{-
We talked about how doing contents <- hGetContents handle doesn't cause the whole file
to be read at once and stored in-memory. It's I/O lazy, so doing this
-}
main = do
  withFile "something.txt" ReadMode (\handle -> do
                                        contents <- hGetContents handle
                                        putStr contents)

