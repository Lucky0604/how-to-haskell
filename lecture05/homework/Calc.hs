module Calc where

import ExprT
import Parser

{-
an evaluator for ExprT, with the signature
eval :: ExprT -> Integer
For example, eval (Mul (Add (Lit 2) (Lit 3)) (Lit 4)) == 20.
-}

-- | pattern match
eval :: ExprT -> Integer
eval (Lit x) = x
eval (Add x y) = eval x + eval y
eval (Mul x y) = eval x * eval y

-- | case of
eval' :: ExprT -> Integer
eval' e = 
	case e of
		Lit n -> n
		Add e1 e2 -> eval' e1 + eval' e2
		Mul e1 e2 -> eval' e1 * eval' e2


{-
evaluates arithmetic expressions given as a String, producing
Nothing for inputs which are not well-formed expressions, and
Just n for well-formed inputs that evaluate to n.
-}
evalStr :: String -> Maybe Integer
evalStr s = 
	case parseExp Lit Add Mul s of
		Just s' -> Just $ eval s'
		Nothing -> Nothing

