-- | nested 'lets'

-- | “nest” multiple let blocks inside each other in an expression
foo = let a = 1
      in let b = 2
         in a + b

-- |  to repeat a variable name in a nested let expression
bar = let x = 1
      in ((let x = "foo" in x), x)

