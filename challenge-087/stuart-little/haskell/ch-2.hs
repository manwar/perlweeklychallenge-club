#!/usr/bin/env runghc

-- run <script> <space-separated 0-1 words, one per matrix row>

import Data.List.Extra (maximumOn,)
import Data.List.Utils (join,)
import System.Environment (getArgs,)

subRect :: [[a]] -> Int -> Int -> Int -> Int -> [[a]]
subRect mat x1 x2 y1 y2 = map (\ls -> map (ls!!) [y1..y2]) $ map (mat!!) [x1..x2]

isAllMat :: Eq a => a -> [[a]] -> Bool
isAllMat c = and.(map (and.map(c==)))

maxRect :: Eq a => a -> [[a]] -> Maybe [[a]]
maxRect c mat
  |null l = Nothing
  |otherwise = Just $ maximumOn (\tab -> (length tab)*(length $ head tab)) l where
     l = filter (isAllMat c) $ map (\(x1,x2,y1,y2)-> subRect mat x1 x2 y1 y2) [(x1,x2,y1,y2) | [x1,x2] <- sequence (replicate 2 [0..(length mat)-1]), [y1,y2] <- sequence (replicate 2 [0..(length $ head mat)-1]), x1 < x2, y1 < y2]
  
main = do
  mat <- getArgs
  putStrLn $ maybe "0" (join "\n") $ maxRect '1' mat
