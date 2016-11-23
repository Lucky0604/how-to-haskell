module Employee where
type Name = String

data Employee = Employee { name :: Name
                         , phone :: String}
                deriving Show

-- | the Employee constructor has type
-- | Employee :: Name -> String -> Employee
