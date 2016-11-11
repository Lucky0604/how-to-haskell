module Read_File where

import System.IO

{-
main = do
  handle <- openFile "girlfriends.txt" ReadMode
  contents <- hGetContents handle
  putStr contents
  hClose handle
-}
{-
openFile :: FilePath -> IOMode -> IO Handle

it states: openFile takes a file path and an IOMode and returns an I/O action
that will open a file and have the file's associated handle encapsulated as its result.
-}



-- | rewrite above func by using `withFile`
-- | withFile :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
main = do
  withFile "girlfriends.txt" ReadMode (\handle -> do
                                          contents <- hGetContents handle
                                          putStr contents)

{-
it has to take a function that returns an I/O action instead
of just taking an I/O action to do and then close the file is
because the I/O action that we'd pass to it wouldn't know on which file to operate.
This way, withFile opens the file and then passes the handle to the function we gave it.
It gets an I/O action back from that function and then makes an I/O action that's just like it,
only it closes the file afterwards
-}
