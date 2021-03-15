#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import System.Environment (getArgs,)
import Data.List (permutations,)

isWave xs = all (0<=) $ zipWith (*) (cycle [1,-1]) (zipWith (-) xs $ tail xs)

main = do
  args <- getArgs  
  print $ filter isWave $ permutations $ map (read::String->Int) args
