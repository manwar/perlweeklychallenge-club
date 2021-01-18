#!/usr/bin/env runghc

-- run <script> <size of the mult_table>

import System.Environment (getArgs,)
import Control.Monad (liftM,)

pad :: Int -> String -> String
pad nr str = (replicate ((-) nr $ length str) ' ') ++ str

main = do
  n <- liftM (read::String->Int) $ liftM head getArgs
  let ln = length $ show (n*n)
  mapM_ putStrLn $ map unwords $ map (\x -> map (\y -> if (y<x) then (replicate ln ' ') else (pad ln (show (x*y)))) [1..n]) [1..n]
