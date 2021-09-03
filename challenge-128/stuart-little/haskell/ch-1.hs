#!/usr/bin/env runghc

-- run <script> <space-separated binary words, with one word representing each row>

import Data.List.Extra (maximumOn)
import Data.List.Split (splitOn)
import System.Environment (getArgs)

maxZeros :: [String] -> (Int,Int)
maxZeros xs = maximumOn (\(a,b)-> a*b) $ map (\(i,j,s)-> ((j-i+1),(length s))) $ map (\(i,j)-> (i,j, maximumOn length $ splitOn "1" $ foldl1 (zipWith max) $ map (xs !!) [i..j]) ) [(i,j) | i <- [0..(length xs -1)], j <- [i..(length xs -1)]]

main :: IO ()
main = getArgs >>=  putStrLn . (\(rows,cols)-> unlines $ replicate rows (replicate cols '0')) . maxZeros
