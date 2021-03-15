#!/usr/bin/env runghc

-- run <script> <nr of terms>

{-# LANGUAGE PackageImports #-}

import System.Environment (getArgs,)
import Data.List (elemIndex,)
import "ghc" Util (nTimes,)

whereSeen :: Int -> [Int] -> Int
whereSeen x xs = maybe 0 (1+) $ elemIndex x xs

vEckTails :: [[Int]]
vEckTails = iterate (\l@(h:t) -> (whereSeen h t):l) [0]

main = do
  nr <- getArgs >>= (return.(read::String->Int).head)
  print $ reverse $ vEckTails !! (nr -1)
