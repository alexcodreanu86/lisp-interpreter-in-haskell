{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Interpreter.OutputFormaterSpec (main, spec) where

import Test.Hspec
import Interpreter.OutputFormater

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "formatWhenInt" $ do
    it "returns input when value is not equivalent to int" $
      formatWhenInt "1.2" `shouldBe` "1.2"

    it "returns a formated integer " $
      formatWhenInt "1.0" `shouldBe` "1"

  describe "strip" $ do
    it "removes the trailing whitespace" $ do
      strip "   1  \t  " `shouldBe` "1"

    it "it returns the original input when there is no whitespace" $
      strip "1" `shouldBe` "1"
