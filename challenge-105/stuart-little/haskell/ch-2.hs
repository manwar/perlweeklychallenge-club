#!/usr/bin/env runghc

-- run <script> <name>

import Data.Char (toLower,toUpper)
import System.Environment (getArgs)

ellis :: Char -> String -> String
ellis c name = (c:"o-") ++ if (c == (toLower $ head name))
  then (tail name)
  else (c:"") ++ (tail name)

verse :: String -> String
verse name = let capName = ((toUpper $ head name):(tail name)) in
  capName ++ ", " ++ capName ++ ", " ++ (ellis 'b' capName) ++ "\n"
  ++ "Bonana-fanna " ++ (ellis 'f' capName) ++ "\n"
  ++ "Fee fi " ++ (ellis 'm' capName) ++ "\n"
  ++ capName ++ "!" 

main = do
  (name:_) <- getArgs
  putStrLn $ verse name
