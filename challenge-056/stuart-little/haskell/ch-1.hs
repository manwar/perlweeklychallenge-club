#!/usr/bin/env runghc

-- run as <script> <space-separated numbers, with the target difference first followed by the array entries>

import System.Environment (getArgs)

diffIdx k xs = filter (\p -> (xs !! (fst p)) - (xs !! (snd p)) == k) pairs
  where pairs = [(i,j) | i <- [0..length xs -1], j <- [0..length xs -1], i /= j]
       
main = do
  args <- getArgs
  let intargs = map (read::String->Int) args
  mapM_ putStrLn $ map show $ diffIdx (head intargs) (tail intargs)
  
