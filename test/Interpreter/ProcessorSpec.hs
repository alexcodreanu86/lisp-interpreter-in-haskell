{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Interpreter.ProcessorSpec (main, spec) where

import Test.Hspec
import Interpreter.Processor

main :: IO ()
main = hspec spec

processesTo :: String -> Float -> Expectation
input `processesTo` output =
  process input `shouldBe` output

spec :: Spec
spec = do
  describe "process" $ do
    it "returns 5 for \"(+ 2 3)\"" $
      "(+ 2 3)" `processesTo` 5

    it "returns 7 for \"(+ 2 (+ 2 3))\"" $
      "(+ 2 (+ 2 3))" `processesTo` 7

    it "returns 8 for \"(+ (+ 2 3) 3)\"" $
      "(+ (+ 2 3) 3)" `processesTo` 8

    it "returns 2 for \"(- (+ 2 3) 3)\"" $
      "(- (+ 2 3) 3)" `processesTo` 2

    it "returns 15 for \"(* (+ 2 3) 3)\"" $
      "(* (+ 2 3) 3)" `processesTo` 15

  describe "pullExpression" $ do
    it "parses the string for a valid expression match" $
      pullExpression "before (+ 1 2 3) after" `shouldBe`
          Just ("before ", "(+ 1 2 3)", " after", [])
