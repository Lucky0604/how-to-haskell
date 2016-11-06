module Basic_IO where

main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  putStrLn ("Hey" ++ name ++ ", you rock!")
-- | to get the value out of an I/O action, you have to perform it inside another I/O action by binding it to a name with <-.
