#!/usr/bin/env runghc

-- run <script> <number>

import System.Environment (getArgs,)
import Data.List (intercalate,)
import Data.Function (fix,)

import Data.List.Extra (maximumOn,dropEnd,)
import Data.Array

-- main: show a sequence

memoize :: (Int -> a) -> (Int -> a)
memoize f = (map f [0 ..] !!)

cltz :: (Int -> [Int]) -> Int -> [Int]
cltz f n
  |n==1 =[1]
  |odd n =(n:(f (3*n+1)))
  |even n =(n:(f (div n 2)))

cltzMem :: Int -> [Int]
cltzMem = fix (memoize . cltz)

{-
bonus: top 20 up to 1_000_000
adapted from
https://stackoverflow.com/a/18537893/11064961
-}

collatzMemoized :: Array Int Int
collatzMemoized = listArray (1, maxNumberToMemoize) $ map collatz [1..maxNumberToMemoize] where
  maxNumberToMemoize = 1000000
  
collatz :: Int -> Int
collatz 1 = 1
collatz n
  | inRange (bounds collatzMemoized) nextValue = 1 + collatzMemoized ! nextValue
  | otherwise = 1 + collatz nextValue
  where
    nextValue = case n of
      1 -> 1
      n | even n -> n `div` 2
        | otherwise -> 3 * n + 1

maxMany :: Ord b => (a -> b) -> [a] -> a -> [a]
maxMany f xs n
  | f n > f (head xs) =(n:(dropEnd 1 xs))
  | otherwise =xs

maxCollatzUpTo :: Int -> Int -> [(Int, Int)]
maxCollatzUpTo n howmany = foldl (maxMany snd) (replicate howmany (0,0)) $ zip [1..n] (map collatz [1..n])

main = do
  args <- getArgs
  let n = read (args !! 0)::Int
  putStrLn $ intercalate " -> " $ map show $ cltzMem n
  mapM_ print $ maxCollatzUpTo 1000000 20
