{-# LANGUAGE OverloadedStrings #-}
module Interpreter.OutputFormater where

import Interpreter.Validator as Validator
import Data.Char
import Text.Regex.Posix

formatOutput :: String -> String
formatOutput = formatWhenInt . strip

strip :: String -> String
strip input = dropWhile isSpace (stripTailWhiteSpace input)

stripTailWhiteSpace :: String -> String
stripTailWhiteSpace input = beforeWhiteSpace
  where (beforeWhiteSpace, _, _) = input =~ ("[ \t\r\n\v\f]+$" :: String) :: (String, String, String)

formatWhenInt :: String -> String
formatWhenInt input
  | Validator.isNumber input = formatNumber input
  | otherwise = input

formatNumber :: String -> String
formatNumber input
  | fromIntegral flooredNumber == originalNumber = show flooredNumber
  | otherwise = input
    where originalNumber = read input :: Float
          flooredNumber = floor originalNumber
