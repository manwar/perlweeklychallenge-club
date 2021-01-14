#!/usr/bin/env runghc

-- run <script> <integer>

import System.Environment (getArgs,)
import System.Random (newStdGen,)
import System.Random.Shuffle (shuffle',)

peaks :: Ord a => [a] -> [a]
peaks l = map fst $ filter (\(x,xs)-> all (x>) xs) $ zip l $ map (\(l,r)-> concat [take 1 (reverse l), take 1 (tail r)]) $ map (\x-> splitAt x l) [0..length l-1]

main = do
  nr <- getArgs >>= return.(read::String->Int).head
  gen <- newStdGen
  let l = take nr $ shuffle' [1..50] 50 gen
  putStrLn $ "Initial list: " ++ (unwords $ map show l)
  putStrLn $ "Peaks: " ++ (unwords $ map show $ peaks l)
