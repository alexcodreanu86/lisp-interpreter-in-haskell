{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Interpreter.ValidatorSpec (main, spec) where

import Test.Hspec
import Interpreter.Validator as Validator

main :: IO ()
main = hspec spec

assertIsValid :: String -> Expectation
assertIsValid input =
  isValid input `shouldBe` True

spec :: Spec
spec = do
  describe "isValid" $ do
    context "with valid input" $ do
      it "returns True with addition operator" $
        assertIsValid "(+ 1 2)"

      it "returns True with subtraction operator" $
        isValid "(- 1 2)" `shouldBe` True

      it "returns True with multiplication operator" $
        isValid "(* 1 2)" `shouldBe` True

      it "returns True with divizion operator" $
        isValid "(/ 1 2)" `shouldBe` True

      it "returns True with for nested input" $

    context "with invalid input" $ do
      it "returns false when no operator is provided" $
        isValid "(1 2)" `shouldBe` False

      it "returns false when no digits are provided" $
        isValid "(+ )" `shouldBe` False

      it "returns false when expression is empty" $
        isValid "" `shouldBe` False
