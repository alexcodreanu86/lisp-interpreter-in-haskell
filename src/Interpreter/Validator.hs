{-# LANGUAGE OverloadedStrings, DataKinds #-}
module Interpreter.Validator where

import Text.Regex.Posix

isValidInput :: String -> Bool
isValidInput input
  | onlyValidCharacters input && (isNumber input || looksLikeAnExpression input) = True
  | otherwise = False

onlyValidCharacters :: String -> Bool
onlyValidCharacters = foldl (\acc char-> ((char < '9') && acc)) True

looksLikeAnExpression :: String -> Bool
looksLikeAnExpression input = input =~ expressionMatcher

isValidExpression :: String -> Bool
isValidExpression input = input =~ validExpressionMather :: Bool

isNumber :: String -> Bool
isNumber input = input =~ validNumberMatcher

expressionMatcher :: String
expressionMatcher = "^[ \t\r\n\v\f]*\\(.+\\)[ \t\r\n\v\f]*$"

validExpressionMather :: String
validExpressionMather = "\\([-+\\*\\/]([ \t\r\n\v\f]+[0-9]+(\\.[0-9]+)?)+\\)"

validNumberMatcher :: String
validNumberMatcher = "^[0-9]+(\\.[0-9]+)?$"
