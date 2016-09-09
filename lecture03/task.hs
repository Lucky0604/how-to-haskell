-- slice a list
-- halve :: [a] -> ([a], [a])
















-- use expression define the '&&' operator
(&&&) :: Bool -> Bool -> Bool
(&&&) a b = if a then b else False


-- using lambda expression replace the expression
mult :: Num a => a -> a -> a -> a
mult x y z = x * y * z
-- lambda expression
mult' :: Num a => a -> a -> a -> a
mult' = \x -> \y -> \z -> x * y * z
