#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import System.Environment (getArgs,)

nbl xs = filter (\x -> length (filter (\y -> x < y) xs) == x) xs
       
main = do
  args <- getArgs  
  putStrLn $ unwords $ map show $ nbl $ map (read::String->Int) args
