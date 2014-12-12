{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Interpreter.ReplSpec (main, spec) where

import Test.Hspec
import Interpreter.Repl as Repl

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "run" $ do
    it "exits when user input is exit" $
      pendingWith "learn how to test user input"
