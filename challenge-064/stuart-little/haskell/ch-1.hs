#!/usr/bin/env runghc

-- run <script>

import Data.List.Split (chunksOf,)
import Data.List.Extra (minimumOn,)
import Data.List (intercalate,)

intertwine :: [a] -> [a] -> [[a]]
intertwine xs ys
  |null xs || null ys = [xs ++ ys]
  |otherwise = (nextIt xs ys ) ++ (nextIt ys xs) where
     nextIt l1 l2 = map ((head l1):) (intertwine (tail l1) l2)

trvSteps :: [Int] -> [Int] -> [a] -> [[a]]
trvSteps as bs l = (map.map) (l !!) $ map (scanl (+) 0) $ intertwine as bs

rightDownMat :: [[a]] -> [[a]]
rightDownMat mat = let (x,y) = (length (mat !! 0), length mat) in trvSteps (replicate (x-1) 1) (replicate (y-1) x) $ concat mat
     
main = do
  let mat = chunksOf 3 [1..9]
  putStrLn "Matrix:"
  mapM_ print mat
  let minpath = minimumOn sum $ rightDownMat mat
  putStrLn $ "Minimal-sum path: " ++ (intercalate "->" $ map show minpath)  
  putStrLn $ "Sum: " ++ (show $ sum minpath)
