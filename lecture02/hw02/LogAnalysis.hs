{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where
import Log

messageType :: [String] -> MessageType
messageType xs
    | t == "I" = Just Info
    | t == "W" = Just Warning
    | t == "E" = Just $ Error $ read $ xs !! 1
    | otherwise = Nothing
    where t = head xs
