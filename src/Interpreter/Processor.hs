{-# LANGUAGE OverloadedStrings #-}
module Interpreter.Processor (process, evaluateExpression) where

import Text.Regex.Posix
import Interpreter.Evaluator as Evaluator
import Interpreter.OutputFormater as Formater
import Interpreter.Validator as Validator

process :: String -> String
process input
  | Validator.isValidInput input =
    Formater.formatOutput $ evaluateInput input
  | otherwise = processMatch input $ Just ("", "", "")

evaluateInput :: String -> String
evaluateInput input =
  processMatch input $ pullExpression input

processMatch :: String -> Maybe (String, String, String) -> String
processMatch input Nothing = input
processMatch input (Just (before, match, after))
  | isValidExpression match =
    let result = before ++ evaluateExpression match ++ after
      in evaluateInput result
  | otherwise = "Invalid expression: " ++ (show input)

evaluateExpression :: String -> String
evaluateExpression input =
  show (Evaluator.evaluate (removeParens input :: String))

removeParens :: String -> String
removeParens (_:input) = init input
removeParens input = input

pullExpression :: String -> Maybe (String, String, String)
pullExpression input
  | matchExpression input = Just (input  =~ expressionMatch :: (String, String, String))
  | otherwise = Nothing

matchExpression :: String -> Bool
matchExpression = (=~ expressionMatch)

expressionMatch :: String
expressionMatch = "\\([^\\(\\)]+\\)"
