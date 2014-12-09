{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Interpreter.EvaluatorSpec (main, spec) where

import Test.Hspec
import Interpreter.Evaluator (evaluate)

main :: IO ()
main = hspec spec

shouldEvaluateTo :: String -> Float -> Expectation
input `shouldEvaluateTo` result =
  evaluate input `shouldBe` result

spec :: Spec
spec = do
  describe "evaluate" $ do
    context "addition" $ do
      it "returns 3 for \"+ 2 1\"" $
        "+ 1 2" `shouldEvaluateTo` 3

      it "returns 5 for \"+ 2 1 1\"" $
        "+ 2 1 1" `shouldEvaluateTo` 4

      it "returns 27 for \"+ 3 6 8 10\"" $
        "+ 3 6 8 10" `shouldEvaluateTo` 27

      it "returns 3.6 for \"+ 1 1 1.6\"" $
        "+ 1 1 1.6" `shouldEvaluateTo` 3.6

    context "multiplication" $ do
      it "returns 2 for \"* 2 1\"" $
        "* 2 1" `shouldEvaluateTo` 2
      it "returns 10 for \"* 2 5\"" $
        "* 2 5" `shouldEvaluateTo` 10

    context "divizion" $ do
      it "returns 2 for \"/ 10 5\"" $
        "/ 10 5" `shouldEvaluateTo` 2

      it "returns 2 for \"/ 12 3 2\"" $
        "/ 12 3 2" `shouldEvaluateTo` 2

    context "subtraction" $ do
      it "returns 3 for \"- 7 4\"" $
        "- 7 4" `shouldEvaluateTo` 3

      it "returns 1 for \"- 7 4 2\"" $
        "- 7 4 2" `shouldEvaluateTo` 1
