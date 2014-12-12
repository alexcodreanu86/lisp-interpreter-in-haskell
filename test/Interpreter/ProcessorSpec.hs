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
    context "simple expression" $ do
      it "returns 5 for \"(+ 2 3)\"" $
        "(+ 2 3)" `processesTo` 5

    context "nested expressoins" $ do
      it "returns 7 for \"(+ 2 (+ 2 3))\"" $
        "(+ 2 (+ 2 3))" `processesTo` 7

      it "returns 8 for \"(+ (+ 2 3) 3)\"" $
        "(+ (+ 2 3) 3)" `processesTo` 8

      it "returns 2 for \"(- (+ 2 3) 3)\"" $
        "(- (+ 2 3) 3)" `processesTo` 2

      it "returns 15 for \"(* (+ 2 3) 3)\"" $
        "(* (+ 2 3) 3)" `processesTo` 15

    context "multiple expressions" $ do
      it "returns 15 for \"(* (+ 2 3) (- 7 1 1))\"" $
        "(* (+ 2 3) (- 7 3 1))" `processesTo` 15

      it "returns 15 for \"(* (+ 2 3) (- 7 (+ 1 3)))\"" $
        "(* (+ 2 3) (- 7 (+ 1 3)))" `processesTo` 15
