#!/usr/bin/env runghc

import Data.List ((\\), inits)
import Data.List.Extra (maximumOn)
import System.Environment (getArgs)

lr :: [String] -> [[String]]
lr xs
  |(length xs < 3) || (head xs == ".") =[[],[]]
  |length xs == 3 =[["."],["."]]
  |otherwise = [l, (tail xs) \\ l] where
     l = head $ filter (((-1)==).sum.map (\x-> if x == "." then (-1) else 1)) $ inits $ tail xs

lrLongPath :: [String] -> [[String]]
lrLongPath xs
  |head xs == "." =[[],[]]
  |length xs == 3 = replicate 2 [head xs]
  |otherwise = map ((head xs):) $ map ((maximumOn length).lrLongPath) $ lr xs     

biLongPath :: [String] -> [String]
biLongPath xs
  |length xs < 3 || head xs == "." =[]
  |length xs == 3 = [head xs]
  |otherwise = maximumOn length [path, biLongPath(left), biLongPath(right)] where
     [left,right] = lr(xs)
     [lPath,rPath] = lrLongPath(xs)
     path = (reverse $ tail lPath) ++ rPath

main :: IO ()
main = getArgs >>= putStrLn.unwords.biLongPath

{-
run <script> <tree in preorder form with '.' for empty nodes, entered as space-separated values>

ref: https://stackoverflow.com/a/2676849/11064961

e.g. 1 2 4 . 7 . . . 3 5 . . 6 . . represents the tree

        1
       / \
      2   3
     /   / \
    4   5   6
     \
      7

given as an example in the problem formulation at https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK2
-}
