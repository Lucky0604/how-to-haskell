module Todo_Script where

{-
one program, what it does will depend on the command line arguments
going to make it so it can operate on different files, not just todo.txt.
-}


{-
Our program will be made so that if we want to add the task
Find the magic sword of power to the file todo.txt,
we have to punch in todo add todo.txt "Find the magic sword of power"
in our terminal. To view the tasks we'll just do todo view todo.txt
and to remove the task with the index of 2, we'll do todo remove todo.txt 2
-}

-- | start by making a dispatch association list

import System.Environment
import System.Directory
import System.IO
import Data.List

dispatch :: [(String, [String] -> IO ())]
dispatch = [("add", add
            ,"view", view
            ,"remove", remove)
           ]

main = do
  (command: args) <- getArgs
  let (Just action) = lookup command dispatch
  action args

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

view :: [String] -> IO ()
view [fileName] = do
  contents <- readFile fileName
  let todoTasks = lines contents
      numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
  putStr $ unlines numberedTasks

-- | remove items by command args
remove :: [String] -> IO ()
remove [fileName, numberString] = do
  handle <- openFile fileName ReadMode
  (tempName, tempHandle) <- openTempFile "." "temp"
  contents <- hGetContents handle
  let number = read numberString
      todoTasks = lines contents
      newTodoItems = delete (todoTasks !! number) todoTasks
  hPutStr tempHandle $ unlines newTodoItems
  hClose handle
  hClose tempHandle
  removeFile fileName
  renameFile tempName fileName
