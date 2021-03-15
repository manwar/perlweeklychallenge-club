#!/usr/bin/env runghc

-- run <script> <two integers separated by arithmetic operator surrounded by whitespace>

import Data.Function (on,)
import Data.Maybe (fromJust,)
import System.Environment (getArgs,)

main = do
  (nr1:op:nr2:_) <- getArgs
  let dsptch :: [(String,Float -> Float -> Float)]
      dsptch = zip (map (\x->[x]) "+-*/") [(+),(-),(*),(/)]
  putStrLn $ "Result: " ++ (show $ ((fromJust (lookup op dsptch)) `on` (read::String->Float)) nr1 nr2)
