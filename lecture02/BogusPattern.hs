-- | incorrectly matching against a variable

data Fruit = Apple | Orange
apple = "apple"
orange = "orange"

whichFruit :: String -> Fruit
whichFruit f = case f of
                apple -> Apple
                orange -> Orange

-- | It is easier to spot the mistake if we rewrite the code in an equational style
equational apple = Apple
equational orange = Orange

-- | corrected version
betterFruit f = case f of
                    "apple" -> Apple
                    "orange" -> Orange
