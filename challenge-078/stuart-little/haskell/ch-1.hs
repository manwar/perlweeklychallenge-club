#!/usr/bin/env runghc

-- run as <script> <space-separated array entries>

import System.Environment   
import Data.List

ldrs xs = map head $ filter (\ys -> (length ys == 1) || length ys > 1 && (head ys > (maximum $ tail ys)) ) $ tails xs
       
main = do  
  args <- getArgs
  putStrLn $ unwords $ map show $ ldrs $ map (read::String->Int) args
