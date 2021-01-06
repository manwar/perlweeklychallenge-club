#!/usr/bin/env runghc

-- run <script> <binary_nr>

import System.Environment (getArgs,)
import Data.List.Extra (groupSortOn,)
import Data.List.Utils (countElem,)

maxOnePairs bin = last $ groupSortOn (\(i,j) -> 2*(countElem '0' (take (j-i+1) $ drop i $ bin)) - (j-i+1)) [(i,j) | i <- [0..length bin], j <- [0..length bin], i <= j]

main = do
  args <- getArgs
  print $ maxOnePairs (args !! 0)
