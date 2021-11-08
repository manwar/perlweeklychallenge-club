#!/usr/bin/env runghc

-- run <script>

{-# LANGUAGE QuasiQuotes #-}

import System.Environment (getArgs)
import Text.RawString.QQ

nbrs :: [[a]] -> Int -> Int -> [(Int,Int)]
nbrs mat i j = filter (\p-> (fst p /= i || snd p /= j) && (0 <= fst p) && (fst p < length mat) && (0 <= snd p) && (snd p < length (head mat))) $ map (\[x,y]->(i+x,j+y)) $ sequence $ replicate 2 [-1..1]

mines :: [[String]] -> [[String]]
mines xs = map (map (\(p,q,r)-> if r == "x" then "x" else show $ length $ filter (\nbr-> (xs !! (fst nbr)) !! (snd nbr) == "x") $ nbrs xs p q)) indexed where
  indexed = map (\(i,ar)-> map (\(j,x) -> (i,j,x)) $ zip [0..] ar) $ zip [0..] xs

inptStr :: String
inptStr=[r|x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x|]

main :: IO ()
main = putStrLn $ unlines $ map unwords $ mines $ map words $ lines inptStr
