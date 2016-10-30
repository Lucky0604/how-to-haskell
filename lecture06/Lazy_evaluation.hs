{-
Lazy evaluation
nder a lazy evaluation strategy, evaluation of function 
arguments is delayed as long as possible: 
they are not evaluated until it actually becomes necessary to do so
-}

-- | two funcs
f1 :: Maybe a -> [Maybe a]
f1 m = [m, m]

f2 :: Maybe a -> [a]
f2 Nothing = []
f2 (Just x) = [x]
-- | important thing to note is that thunks are evaluated only enough to allow a pattern match to proceed, and no further!

{-
pattern matching drives evaluation
- Expressions are only evaluated when pattern-matched
- …only as far as necessary for the match to proceed, and no farther!
-}

-- | evaluate take 3 (repeat 7)
repeat :: a -> [a]
repeat x = x : repeat x

take :: Int -> [a] -> a
take n _
	| n <= 0 = []
take _ [] = []
take n (x: xs) = x : take (n - 1) xs
{-
Carrying out the evaluation step-by-step looks something like this:

  take 3 (repeat 7)
      { 3 <= 0 is False, so we proceed to the second clause, which
    needs to match on the second argument. So we must expand
    repeat 7 one step. }
= take 3 (7 : repeat 7)
      { the second clause does not match but the third clause
        does. Note that (3-1) does not get evaluated yet! }
= 7 : take (3-1) (repeat 7)
      { In order to decide on the first clause, we must test (3-1)
        <= 0 which requires evaluating (3-1). }
= 7 : take 2 (repeat 7)
      { 2 <= 0 is False, so we must expand repeat 7 again. }
= 7 : take 2 (7 : repeat 7)
      { The rest is similar. }
= 7 : 7 : take (2-1) (repeat 7)
= 7 : 7 : take 1 (repeat 7)
= 7 : 7 : take 1 (7 : repeat 7)
= 7 : 7 : 7 : take (1-1) (repeat 7)
= 7 : 7 : 7 : take 0 (repeat 7)
= 7 : 7 : 7 : []
-}


-- | ---------------------------------------------
-- | Haskell code to solve the 0-1 knapsack problem
import Data.Array
knapsack01 :: [Double] 	-- values
					 -> [Integer] -- nonnegative weights
					 -> Integer   -- knapsack size
					 -> Double    -- max possible value

knapsack01 vs ws maxW = m!(numItems - 1, maxW)
	where numItems = length vs
				m = array ((-1, 0), (numItems - 1, maxW)) $
					[((-1, w), 0) | w <- [0..maxW]] ++
					[((i, 0), 0) | i <- [0..numItems - 1]] ++ 
					[((i, w), best)
						| i <- [0..numItems - 1]
						, w <- [1..maxW]
						, let best
							| ws !! i > w = m!(i - 1, w)
							| otherwise = max (m!(i - 1, w))
																(m!(i - 1, w - ws !! i) + vs !! i)]

example = knapsack01 [3,4,5,6,10] [2,3,4,5,9] 20

















