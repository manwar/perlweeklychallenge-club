#!/usr/bin/env runghc

-- run <script> <nr of bits>

import Data.List.Split (chunksOf,)
import System.Environment (getArgs,)

binStrToDec :: String -> Int
binStrToDec b = sum $ zipWith (*) (iterate (2*) 1) $ map (read::String->Int) $ chunksOf 1 $ reverse b

gray :: Int -> [String]
gray n
  |n==0 =[""]
  |otherwise = (map ('0':) l) ++ (map ('1':) $ reverse l) where
     l = gray (n-1)

main = do
  nrbits <- getArgs >>= return.(read::String->Int).head
  print $ map binStrToDec $ gray nrbits
