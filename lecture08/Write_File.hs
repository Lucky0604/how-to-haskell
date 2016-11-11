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
{-
main = do
  withFile "something.txt" ReadMode (\handle -> do
                                        contents <- hGetContents handle
                                        putStr contents)
-}


-- | control exactly buffering
{-
control how exactly buffering is done by using the hSetBuffering function.
It takes a handle and a BufferMode and returns an I/O action that sets the buffering.
BufferMode is a simple enumeration data type and the possible values it can hold are:
NoBuffering, LineBuffering or BlockBuffering (Maybe Int).
The Maybe Int is for how big the chunk should be, in bytes.
If it's Nothing, then the operating system determines the chunk size.
NoBuffering means that it will be read one character at a time.
NoBuffering usually sucks as a buffering mode because it has to access the disk so much.
-}
-- |  it doesn't read it line by line but reads the whole file in chunks of 2048 bytes
{-
main = do
  withFile "something.txt" ReadMode (\handle -> do
                                        hSetBuffering handle $ BlockBuffering (Just 2048)
                                        contents <- hGetContents handle
                                        putStr contents)
-}


-- | -----------------------------------------------------------------
{-
the program for removing an item from todo.txt:
-}
import System.IO
import System.Directory
import Data.List

main = do
  handle <- openFile "todo.txt" ReadMode
  (tempName, tempHandle) <- openTempFile "." "temp"
  contents <- hGetContents handle
  let todoTasks = lines contents
      numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
  putStrLn "These are your TO-DO items:"
  putStr $ unlines numberedTasks
  putStrLn "Which one do you want to delete?"
  numberString <- getLine
  let number = read numberString
      newTodoItems = delete (todoTasks !! number) todoTasks
  hPutStr tempHandle $ unlines newTodoItems
  hClose handle
  hClose tempHandle
  removeFile "todo.txt"
  renameFile tempName "todo.txt"
