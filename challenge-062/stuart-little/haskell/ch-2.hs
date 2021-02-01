#!/usr/bin/env runghc

{-
run <script> <size N of N x N x N board, or nothing to default to N=2>

Returns a list of three-coordinate positions for the queens, and is very slow for boards 4 x 4 x 4 or larger.
-}

import Data.List (group)
import Data.Tree (Tree,unfoldTree,levels)
import Safe (headDef)
import System.Environment (getArgs)

type Poss = [[Int]]

board :: Int -> Int -> [[Int]]
board dm n = sequence $ replicate dm [0..n-1]

attacks :: (Eq a, Num a) => [a] -> [a] -> Bool
attacks xs ys = (<=1) . length . group . filter (/=0) $ ls where
  ls = abs <$> (zipWith (-) xs ys)

elimAttacks :: (Eq a, Num a) => [[a]] -> [[a]] -> [[a]]
elimAttacks xss yss = filter (\ys -> all (not . attacks ys) xss) yss

nextNonAtt :: Poss -> Poss -> (Poss, [Poss])
nextNonAtt brd poss = (poss, map (:poss) $ elimAttacks poss brd)

quTree :: Int -> Int -> Tree Poss
quTree dm n = unfoldTree (nextNonAtt $ board dm n) []

main = do
  n <- getArgs >>= return . (read::String->Int) . headDef "2"
  print $ head $ last $ levels $ quTree 3 n
