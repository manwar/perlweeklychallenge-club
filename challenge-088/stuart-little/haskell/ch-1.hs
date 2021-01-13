#!/usr/bin/env runghc

-- run as <script> <space-separated numbers>

import System.Environment   
import Data.List

prods xs = map (\p -> (product $ fst p) * (product $ tail $ snd p)) $ map ((flip splitAt) xs) [0..length xs-1]
       
main = do  
  args <- getArgs
  let xs = map (read::String->Int) args
  putStrLn $ unwords $ map show $ prods xs
