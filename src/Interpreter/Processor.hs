{-# LANGUAGE OverloadedStrings #-}
module Interpreter.Processor where

import Text.Regex
import Interpreter.Evaluator (evaluate)

process :: String -> Float
process input =
  processMatch input $ pullExpression input

processMatch :: String -> Maybe (String, String, String, [String]) -> Float
processMatch input Nothing = read input
processMatch _ (Just (before, match, after, _)) = do
  let result = before ++ (evaluateExpression match) ++ after
    in process result

evaluateExpression :: String -> String
evaluateExpression input =
  show $ evaluate (strip input :: String)

strip :: String -> String
strip (_:input) = init input

pullExpression :: String -> Maybe (String, String, String, [String])
pullExpression input = matchRegexAll expressionRegex input

expressionRegex :: Regex
expressionRegex = (mkRegex "\\([^\\(\\)]+\\)")
