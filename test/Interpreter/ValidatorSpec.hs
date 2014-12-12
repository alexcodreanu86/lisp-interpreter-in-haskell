{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Interpreter.ValidatorSpec (main, spec) where

import Test.Hspec
import Interpreter.Validator as Validator

main :: IO ()
main = hspec spec

assertIsValid :: String -> Expectation
assertIsValid input =
  isValid input `shouldBe` True

assertIsInvalid :: String -> Expectation
assertIsInvalid input =
  isValid input `shouldBe` False

spec :: Spec
spec = do
  describe "isValid" $ do
    context "with valid input" $ do
      it "returns True with addition operator" $
        assertIsValid "(+ 1 2)"

      it "returns True with subtraction operator" $
        assertIsValid "(- 1 2)"

      it "returns True with multiplication operator" $
        assertIsValid "(* 1 2)"

      it "returns True with divizion operator" $
        assertIsValid "(/ 1 2)"

      it "returns True with for nested input" $
        assertIsValid "(+ 1 (+ 1 2))"

    context "with invalid input" $ do
      it "returns false when no operator is provided" $
        assertIsInvalid "(1 2)"

      it "returns false when no digits are provided" $
        assertIsInvalid "(+ )"

      it "returns false when no operator is provided" $
        assertIsInvalid "(1 2)"

      it "returns false when expression is empty" $
        assertIsInvalid ""
