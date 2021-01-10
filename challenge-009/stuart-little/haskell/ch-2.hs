#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import System.Environment (getArgs,)
import Data.List (sort,nub,group,)

rankWith :: (Eq a, Ord a) => ([Int] -> [Int]) -> [a] -> [(a,Int)]
rankWith tally xs = zip (nub sorted) (tally $ map length $ group $ sorted) where
  sorted = sort xs

rankStd :: (Eq a, Ord a) => [a] -> [(a,Int)]
rankStd = rankWith (scanl (+) 1) 

rankMod :: (Eq a, Ord a) => [a] -> [(a,Int)]
rankMod = rankWith (scanl1 (+))

rankDense :: (Eq a, Ord a) => [a] -> [(a,Int)]
rankDense = rankWith ((scanl1 (+)).(map (const 1)))

pp :: Show a => [(a,Int)] -> [String]
pp xs = map (\(n,r) -> ((show n) ++ " -> Rank " ++ (show r))) xs

main = do
  args <- getArgs
  let argsnum = map (read::String->Int) args
  putStrLn "Standard Ranking:"
  mapM_ putStrLn $ pp $ rankStd argsnum
  putStrLn "Modified Ranking:"
  mapM_ putStrLn $ pp $ rankMod argsnum
  putStrLn "Dense Ranking:"
  mapM_ putStrLn $ pp $ rankDense argsnum
