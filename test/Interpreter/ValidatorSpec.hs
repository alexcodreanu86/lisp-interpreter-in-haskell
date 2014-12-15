{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Interpreter.ValidatorSpec (main, spec) where

import Test.Hspec
import Interpreter.Validator as Validator

main :: IO ()
main = hspec spec

assertIsValid :: String -> Expectation
assertIsValid input =
  isValidExpression input `shouldBe` True

assertIsInvalid :: String -> Expectation
assertIsInvalid input =
  isValidExpression input `shouldBe` False

spec :: Spec
spec = do
  describe "isValidInput" $ do
    context "returns True" $ do
      it "when input is a number" $
        isValidInput "123" `shouldBe` True

      it "when input looks like an expression" $
        isValidInput "(1 2 3)" `shouldBe` True

    context "returns False" $ do
      it "when expression is not a number" $
        isValidInput "hello" `shouldBe` False

      it "when it contains invalid characters" $
        isValidInput "Ω" `shouldBe` False

      it "when expression is not formated correctly" $ do
        isValidInput "1 2 (+ 12 3)" `shouldBe` False
        isValidInput "(+ 1 2) 1 2 3" `shouldBe` False

  describe "isNumber" $ do
    context "returns True" $ do
      it "when input is a floating number" $
        isNumber "1.2" `shouldBe` True

      it "when input is an integer" $
        isNumber "12" `shouldBe` True

    context "returns False" $ do
      it "when input is NOT a number" $
        isNumber "test" `shouldBe` False

      it "when contains text and digits at the end" $
        isNumber "test number 3.3" `shouldBe` False

      it "when contains digits in the begining and text at the end" $
        isNumber "3.3 test number" `shouldBe` False

  describe "isValidExpresion" $ do
    context "returns True" $ do
      it "with addition operator" $
        assertIsValid "(+ 1 2)"

      it "with subtraction operator" $
        assertIsValid "(- 1 2)"

      it "with multiplication operator" $
        assertIsValid "(* 1 2)"

      it "with divizion operator" $
        assertIsValid "(/ 1 2)"

      it "with for nested input" $
        assertIsValid "(+ 1 (+ 1 2))"

      it "with tabs inside an expression" $
        assertIsValid "(+ 1 2 \t 4)"

    context "returns False" $ do
      it "when no operator is provided" $
        assertIsInvalid "(1 2)"

      it "when no digits are provided" $
        assertIsInvalid "(+ )"

      it "when no operator is provided" $
        assertIsInvalid "(1 2)"

      it "when expression is empty" $
        assertIsInvalid ""

