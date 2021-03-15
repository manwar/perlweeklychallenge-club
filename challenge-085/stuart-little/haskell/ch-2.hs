#!/usr/bin/env runghc

-- run <script> <number>

import Data.List.Extra (notNull,)
import Math.TreeFun.Tree (boolToInt,)
import System.Environment (getArgs,)

isPow :: Int -> Bool
isPow n
  |n<1 =False
  |n==1 =True
  |otherwise =notNull [(a,b) | a <- [2..(floor $ sqrt $ fromIntegral n)], b <- [2..(n-1)], a ^ b == n]

main = do
  nr <- getArgs >>= return.(read::String->Int).head
  putStrLn $ show $ boolToInt $ isPow nr
