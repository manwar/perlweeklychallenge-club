#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import System.Environment (getArgs,)
import Control.Monad (liftM,)
import Data.Digits (digitsRev,)
import Data.List (transpose,)
import Data.List.Utils (countElem,)

diffs :: Int -> [Int] -> Int
diffs l xs = let (zeros,ones,lxs) = (countElem 0 xs,countElem 1 xs,length xs) in
      div (l*(l-1) - ones*(ones - 1) - (zeros + l - lxs)*(zeros+l - lxs - 1)) 2

main = do
  nrs <- liftM (map (read::String->Int)) getArgs
  print $ sum $ map (diffs $ length nrs) $ transpose $ map (digitsRev 2) nrs
