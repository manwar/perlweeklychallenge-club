#!/usr/bin/env runghc

import Data.Char (isDigit)
import Data.List ((\\), inits)
import Data.Tree (Tree, drawTree, unfoldTree)
import System.Environment (getArgs)

sumMinNrs :: [String] -> [String]
sumMinNrs xs = map (\x -> if (all isDigit x) then show (sm - ((read::String->Int)) x) else x) xs where
  sm = sum $ map (read::String->Int) $ filter (all isDigit) xs

split2trees :: [String] -> ([String],[String])
split2trees xs = (lhalf, xs \\ lhalf) where
  lhalf = head $ dropWhile (\ys -> 2*(length $ filter (\s -> s==".") ys) <= length ys ) $ inits xs

nodeIter :: [String] -> (String, [[String]])
nodeIter xs = if (head xs == ".") then ("",[]) else (head xs, [lchild,rchild]) where
  (lchild,rchild) = split2trees $ tail xs

mkTree :: [String] -> Tree String
mkTree  = unfoldTree nodeIter
  
main = do
  outTreeList <- getArgs >>= return . sumMinNrs . (\x -> if (not $ null x) then x else ["1", "2", "4", ".", "7", ".", ".", ".", "3", "5", ".", ".", "6", ".", "."])  
  putStrLn $ drawTree $ mkTree outTreeList
{--
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
--}
