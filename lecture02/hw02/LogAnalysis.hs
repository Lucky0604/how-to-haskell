{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where

import Data.Maybe
import Log

extractType :: [String] -> Maybe MessageType
extractType xs
    | t == "I" = Just Info
    | t == "W" = Just Warning
    | t == "E" = Just $ Error $ read $ xs !! 1
    | otherwise = Nothing
    where t = head xs

extractTimeStamp :: [String] -> TimeStamp
extractTimeStamp xs =
  read $ case messageType of
    Error _ -> xs !! 2
    _ -> xs !! 1
  where messageType = fromJust $ extractType xs


extractText :: [String] -> String
extractText xs =
  unwords $ case messageType of
    Error _ -> drop 3 xs
    _ -> drop 2 xs
  where messageType = fromJust $ extractType xs

-- | exercise 1
parseMessage :: String -> LogMessage
parseMessage s =
  case mmt of
    Just mt -> LogMessage mt (extractTimeStamp xs) (extractText xs)
    Nothing -> Unknown s
  where
    xs = words s
    mmt = extractType xs

parse :: String -> [LogMessage]
parse = map parseMessage . lines


-- | exercise 2
insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) t = t
insert m Leaf = Node Leaf m Leaf
insert m@(LogMessage _ ts _) t@(Node lst cm@(LogMessage _ cts _) rst)
  | ts > cts = Node lst cm (insert m rst)
  | ts < cts = Node (insert m lst) cm rst
  | otherwise = t

-- | exercise 3
build :: [LogMessage] -> MessageTree
build = foldl (flip insert) Leaf

-- | exercise 4
inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node lst m rst) = inOrder lst ++ [m] ++ inOrder rst

-- | exercise 5
whatWentWrong :: [LogMessage] -> [String]
whatWentWrong =
  map (\(LogMessage _ _ m) -> m) . filter isImportantError . inOrder . build
  where
    isImportantError (LogMessage t _ _) =
      case t of
        Error n -> n > 50
        _ -> False


