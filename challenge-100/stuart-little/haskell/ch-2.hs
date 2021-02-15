#!/usr/bin/env runghc

-- run <script> <space-separated array entries, right-to-left and top-to-bottom>

import Data.List.Split (splitPlaces)
import System.Environment (getArgs)

redStep :: (Num a, Ord a) => [a] -> [a] -> [a]
redStep row1@(h:rest) = zipWith (+) ((h:(zipWith min row1 rest)) ++ [last row1])

collapseTriang :: (Num a, Ord a) => [[a]] -> a
collapseTriang = minimum . foldl1 redStep

main = do
  nrs <- getArgs >>= return . map (read::String->Int) 
  print $ collapseTriang $ splitPlaces [1..] nrs
