#!/usr/bin/env runghc

-- run <script> <nr_digits> <upper_bound> <space-separated numbers>

import System.Environment (getArgs,)
import Data.List ((\\),intersect,isPrefixOf,)

canParse :: Eq a => [a] -> [[a]] -> Bool
canParse xs xss
  |null xs =True
  |otherwise = any (\ys -> canParse (xs \\ ys) xss) $ filter (\ys -> isPrefixOf ys xs) xss
  
main = do
  (nrdig_str:upperbd_str:nrs) <- getArgs
  let (nrdig:upperbd:_) = map (read::String->Int) (nrdig_str:[upperbd_str])
  print $ filter (\nr -> canParse (show nr) nrs) $ intersect [0..upperbd-1] [10^(nrdig-1)..10^nrdig-1]
