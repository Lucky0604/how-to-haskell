-- | pattern matching
myNot True = False
myNot False = True


-- | in the x : xs pattern, (:) is the familiar list constructor
sumList (x : xs) = x + sumList xs
sumList [] = 0