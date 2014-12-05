{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Interpreter.EvaluaterSpec where

import Test.Hspec
import Interpreter.Evaluater

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "evaluate" $ do
    it "returns 3 for \"+ 2 1\"" $
      evaluate "+ 2 1" `shouldBe` 3

    it "true should be false" $
      True `shouldBe` False

