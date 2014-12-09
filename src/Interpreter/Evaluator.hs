{-# LANGUAGE OverloadedStrings #-}
module Interpreter.Evaluator where

import Data.Char

evaluate :: String -> Float
evaluate ('+':rest) = add' rest
evaluate ('*':rest) = multiply' rest
evaluate ('/':rest) = divide' rest
evaluate ('-':rest) = subtract' rest
evaluate _ = error "Invalid Input"

add' ::  String -> Float
add' = evaluateWith (+)

multiply' :: String -> Float
multiply' = evaluateWith (*)

divide' :: String -> Float
divide' = evaluateWith (/)

subtract' ::String -> Float
subtract' = evaluateWith (-)

evaluateWith :: (Float -> Float -> Float) -> String -> Float
evaluateWith f input =
  let numbers = filter isValidNumber $ words input
  in
    foldl1 f $ map readNumber numbers

readNumber :: String -> Float
readNumber input = read input ::Float

isValidNumber :: String -> Bool
isValidNumber = all isPartOfNumber

isPartOfNumber :: Char -> Bool
isPartOfNumber inputChar = isDigit inputChar || inputChar == '.'
