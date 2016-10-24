{-
We'd introduce the x:xs pattern and then we'd do some action that involves a single element and the rest of the list.
It turns out this is a very common pattern, so a couple of very useful functions were introduced to encapsulate it.
These functions are called folds. They're sort of like the map function, only they reduce the list to some single value


A fold takes a binary function, a starting value (I like to call it the accumulator)
and a list to fold up. The binary function itself takes two parameters.
The binary function is called with the accumulator and
the first (or last) element and produces a new accumulator.
Then, the binary function is called again with the new accumulator and the now new first (or last) element,
and so on. Once we've walked over the whole list, only the accumulator remains, which is what we've reduced the list to.
-}

-- | left fold, folds the list up from the left side
-- | foldl function
-- | rewrite sum func using foldl
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

-- | implementation ever more succinctly
sum'' :: (Num a) => [a] -> a
sum'' = foldl (+) 0
-- | The lambda function (\acc x -> acc + x) is the same as (+)


-- | implementation elem func using foldl
elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys

-- | The right fold, foldr works in a similar way to the left fold, only the accumulator eats up the values from the right
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs
