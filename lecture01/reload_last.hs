-- task
-- overwrite the last function, use `drop`, `length`

last' [] = []
last' (x:xs) = drop ((length (x:xs)) - 1) (x: xs)

-- it also can be
last'' [] = []
last'' (x: xs) = drop (length xs) (x: xs)

-----------------------------------------

-- task
-- two ways to impl `init` func(remove the last item in a non-empty list)
init' [] = []
init' (x: xs) = take (length xs) (x: xs)

-- first reverse the list
-- reverse [1,2,3,4] => [4,3,2,1]
-- then tail the list [4,3,2,1] => [3,2,1]
-- finally reverse the result list => [1,2,3]
init'' [] = []
init'' (x: xs) = reverse (tail (reverse (x: xs)))