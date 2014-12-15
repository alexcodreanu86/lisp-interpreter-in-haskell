{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Interpreter.ProcessorSpec (main, spec) where

import Test.Hspec
import Interpreter.Processor

main :: IO ()
main = hspec spec

processesTo :: String -> String -> Expectation
input `processesTo` output =
  process input `shouldBe` output

spec :: Spec
spec = do
  describe "process" $ do
    context "simple expression" $ do
      it "returns 5 for \"(+ 2 3)\"" $
        "(+ 2 3)" `processesTo` "5"

      it "returns 5 for \"(+ 2 \t 3)\"" $
        "(+ 2 \t 3)" `processesTo` "5"

    context "nested expressoins" $ do
      it "returns 7 for \"(+ 2 (+ 2 3))\"" $
        "(+ 2 (+ 2 3))" `processesTo` "7"

      it "returns 8 for \"(+ (+ 2 3) 3)\"" $
        "(+ (+ 2 3) 3)" `processesTo` "8"

      it "returns 2 for \"(- (+ 2 3) 3)\"" $
        "(- (+ 2 3) 3)" `processesTo` "2"

      it "returns 15 for \"(* (+ 2 3) 3)\"" $
        "(* (+ 2 3) 3)" `processesTo` "15"

    context "multiple expressions" $ do
      it "returns 15 for \"(* (+ 2 3) (- 7 1 1))\"" $
        "(* (+ 2 3) (- 7 3 1))" `processesTo` "15"

      it "returns 15 for \"(* (+ 2 3) (- 7 (+ 1 3)))\"" $
        "(* (+ 2 3) (- 7 (+ 1 3)))" `processesTo` "15"

    context "floating point result" $ do
      it "returns \"3.2\" for \"(+ 1.2 2)\"" $
        "(+ 1.2 2)" `processesTo` "3.2"

    context "expression is number" $ do
      it "returns the number given if it is number" $ do
        "123" `processesTo` "123"
        "1.23" `processesTo` "1.23"

    context "invalid input" $ do
      it "returns \"Invalid expression: (+ 2 3 hello)\" for (+ 2 3 hello)" $
        "(+ 2 3 hello)" `processesTo` "Invalid expression: \"(+ 2 3 hello)\""

      it "returns \"Invalid expression: 1 2 (+ 2 3)\" for \"1 2 (+ 2 3)\"" $
        "1 2 (+ 2 3)" `processesTo` "Invalid expression: \"1 2 (+ 2 3)\""

    context "expression contains extra white space arround it" $ do
      it "trims the white space arrount the expression" $
        "    (+ 1 2 3)      " `processesTo` "6"
