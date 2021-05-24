#!/usr/bin/env runghc

-- run <script> <number>

import Data.List (intercalate)
import System.Environment (getArgs)

memoSteps :: Int -> [[Int]]
memoSteps = (map memo [0 ..] !!)
   where memo 0 = [[1]]
         memo 1 = [[1,1],[2]]
         memo n = (map (1:) $ memoSteps (n-1)) ++ (map (2:) $ memoSteps (n-2))

main = do
  nr <- getArgs >>= return . (read::String->Int) . head
  let res = memoSteps (nr-1)
  putStrLn $ (show $ length res) ++ "\n" ++ (replicate 12 '-')
  putStrLn $ intercalate "\n" $ map unwords $ (map.map) show res
