{-# LANGUAGE OverloadedStrings, DataKinds #-}
module Interpreter.Validator where

import Text.Regex.Posix

isValid :: String -> Bool
isValid input = input =~ validExpressionMather :: Bool

validExpressionMather :: String
validExpressionMather = "\\([-+\\*\\/]( +[0-9]+(\\.[0-9]+)?)+\\)"
