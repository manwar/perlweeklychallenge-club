#!/usr/bin/env runghc

-- run as <script> <number>

import System.Environment   
import Data.List

fibs = scanl (+) 1 (1:fibs)
sums nr xs = sort $ filter ((nr ==).sum) $ subsequences $ takeWhile (nr >=) xs
       
main = do  
  args <- getArgs
  mapM_ putStrLn $ map unwords $ map (\xs -> map show xs) $ sums (read (args !! 0)::Int) fibs
