{-# LANGUAGE OverloadedStrings #-}
module Interpreter.Repl (run) where

import Interpreter.Processor

run :: IO()
run = do
  putStrLn "Starting Repl....."
  putStrLn "Repl ready!"
  runRepl

runRepl :: IO()
runRepl = do
  putStrLn "lisp: >"
  getUserInput

getUserInput :: IO()
getUserInput = do
  input <- getLine
  processInput input

processInput ::String -> IO()
processInput "exit" = putStrLn "\nThanks for trying this little program"
processInput input = do
  putStrLn $ "=> " ++ process input
  runRepl
