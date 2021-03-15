#!/usr/bin/env runghc

-- run <script> <binary string> <number>

import Data.List (transpose,elemIndices)
import Data.List.Extra (maximumOn)
import Data.List.Split (chunksOf)
import System.Environment (getArgs)

mostOccsTgt :: Eq a => [[a]] -> [a]
mostOccsTgt xss = map (\ys -> maximumOn (length . (flip elemIndices ys)) ys) $ transpose xss

nrFlips :: Eq a => [a] -> [[a]] -> Int
nrFlips tgt strs = sum $ map (\s -> length $ filter (\(p,q)-> p/=q) $ zip tgt s) strs

main = do
  (bin,nr) <- getArgs >>= return.(\(x:y:_)-> (x,(read::String->Int) y))
  let bins = chunksOf nr bin
      tgt = mostOccsTgt bins
  putStrLn $ "Initial binary words:\n" ++ (unlines bins)
  putStrLn $ "Target string: " ++ tgt
  putStrLn $ "Need to flip " ++ (show $ nrFlips tgt bins) ++ " position(s)."
