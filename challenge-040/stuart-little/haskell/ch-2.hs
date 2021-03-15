#!/usr/bin/env runghc

{-
run <script> <comma-separated index places (no spaces!) followed by space(s) and space-separated numbers>

e.g. <script> 0,2,5 10 4 1 8 12 3

for the example at

https://perlweeklychallenge.org/blog/perl-weekly-challenge-040/#TASK2
-}

import System.Environment (getArgs,)
import Data.List (sort,transpose,)
import Data.List.Split (splitWhen,splitOn,)

splitAtIdxs idxs xs = (map.map) snd $ splitWhen (\p -> elem (fst p) idxs) $ zip [0..] xs

sortAtIdxs idxs xs = concat.concat $ transpose [unsorted,sorted] where
  sorted = map (\x->[x]) $ sort $ map (xs !!) idxs
  unsorted = splitAtIdxs idxs xs

main = do
  args <- getArgs
  let (idxs,xs) = (map (read::String->Int) $ splitOn "," $ head args, map (read::String->Int) $ tail args)
  putStrLn $ unwords $ map show $ sortAtIdxs idxs xs
  
