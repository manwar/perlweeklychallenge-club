#!/usr/bin/env runghc

-- run <script> <target sum> <space-separated coin values>

import System.Environment (getArgs,)

decomps :: (Num a, Ord a) => a -> [a] -> [[a]]
decomps sum vals
  |sum==0 =[[]]
  |otherwise = concat $ map (\val-> map (val:) $ decomps (sum - val) $ filter (val <=) vals) $ filter (sum >=) vals

main = do
  (sum:coins) <- getArgs >>= return.(map (read::String->Int))
  mapM_ print $ decomps sum coins
