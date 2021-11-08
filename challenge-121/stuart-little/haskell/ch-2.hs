#!/usr/bin/env runghc

-- run <script> <nr of cities>

import Data.List (permutations)
import Data.List.Extra (minimumOn)
import System.Environment (getArgs)
import System.Random (newStdGen,randomRs)

mkMat :: Int -> [Int] -> [[Int]]
mkMat n xs = map (\i-> map (\j-> if (i==j) then 0 else xs !! ((i-1)*n+j-1)) [1..n]) [1..n]

mkRMat :: Int -> IO [[Int]]
mkRMat n = do
  gen <- newStdGen
  return $ mkMat n $ randomRs (1,9) gen

sayMat :: [[Int]] -> String
sayMat m = unlines $ map unwords $ map (map show) m

pathCost :: [Int] -> [[Int]] -> Int
pathCost pth mat =
  sum $ map (\i-> (mat !! (pth !! i)) !! (pth !! (mod (i+1) (length pth)))) $ [0..length pth-1]

minPath :: [[Int]] -> ([Int],Int)
minPath mat = minimumOn snd $ map (\l-> (l , pathCost l mat)) $ permutations [0..length mat-1]

main = do
  nr <- getArgs >>= return.(read::String->Int).head
  mat <- mkRMat nr
  let sol = minPath mat
  putStrLn $ "Your matrix:\n" ++ sayMat mat
  putStrLn $ "Optimal cost: " ++ (show $ snd sol)
  putStrLn $ "Optimal path:\n" ++ (unwords $ map show $ (fst sol) ++ [head $ fst sol])
