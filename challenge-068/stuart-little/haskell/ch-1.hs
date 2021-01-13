#!/usr/bin/env runghc

-- run <script> <space-separated 0-1_words, one word per row>

import System.Environment (getArgs,)
import Data.List (transpose,)

zeroRows :: Ord a => [[a]] -> [[a]]
zeroRows mat = map (\l -> replicate (length l) (minimum l)) mat

main = do
  mat <- getArgs
  putStrLn ((replicate 40 '-') ++ "\nInitial matrix:")
  mapM_ putStrLn mat
  putStrLn ((replicate 40 '-') ++ "\nTransformed matrix:")
  mapM_ putStrLn $ zipWith (zipWith min) (zeroRows mat) (transpose $ zeroRows $ transpose mat)
