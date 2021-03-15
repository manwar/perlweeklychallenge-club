#!/usr/bin/env runghc

-- run <script> <space-separated array entries>

import Data.List (transpose)
import Data.List.Extra (minimumOn)
import Data.List.Utils (join)
import System.Environment (getArgs)
import Text.Printf (printf)

rtcc :: [[a]] -> [[a]]
rtcc = reverse . transpose

pck :: Int -> Int -> [a] -> [[a]]
pck m n as
  |m==1 = [as]
  |n==1 = sequence [reverse as]
  |otherwise = smlr ++ [take n as] where
     smlr = rtcc $ pck n (m-1) $ drop n as

rowsToPack :: Int -> Int
rowsToPack n = minimumOn (\x -> abs (x - (div n x))) $ filter ((==0).(mod n)) [1..(div n 2)]

main = do
  args <- getArgs
  let ln = length args
      m = rowsToPack ln
      n = div ln m
  putStrLn $ join "\n" $ map (join " ") $ (map.map) (printf "%5s") $ pck m n args
