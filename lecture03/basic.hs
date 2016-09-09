-- tuple style
fst' :: (a, b) -> a
fst' (x, _) = x

-- lambda expression

add' x y = x + y
-- replace with lambda
add'' = \x -> \y -> x + y

const' :: a -> b -> a
const' x _ = x
-- replace with lambda
const'' :: a -> (b -> a)
const'' x = \_ -> x

odds' :: Int -> [Int]
odds' n = map f [0..n-1]
            where f x = x * 2 + 1
-- replace with lambda
odds'' :: Int -> [Int]
odds'' n = map (\x -> 2 * x + 1) [0..n-1]
