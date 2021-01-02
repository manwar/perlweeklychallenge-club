#!/usr/bin/env runghc

-- run as <script> <space-separated words consisting of 'x' and '0', one word per row>

import System.Environment   
import Data.List
import Control.Monad

pad mat chr =
  let xs = (replicate (length (mat !! 0)) chr)
  in map (\x -> [chr] ++ x ++ [chr]) $ [xs] ++ mat ++ [xs]

nbrs mat i j = map (\(x,y) -> mat !! x !! y) [(x,y) | x <- (liftM2 (+) [i] [-1..1]), y <- (liftM2 (+) [j] [-1..1]), (x,y) /= (i,j)]

main = do  
  args <- getArgs
  let mat = pad args '0'
  putStrLn $ show $ length [(i,j) | i <- [1..(length args)], j <- [1..(length (args !! 0))], mat !! i !! j == 'x', all ('0'==) (nbrs mat i j) ]
