{-# LANGUAGE OverloadedStrings #-}
module Interpreter.Repl (run) where

import Interpreter.Processor

run :: IO()
run = do
  putStr "\n lisp: > "
  input <- getLine
  if input == "exit"
     then putStrLn "Thanks for trying this little program"
     else do
       putStrLn $ "\n" ++ show (process input)
       run
