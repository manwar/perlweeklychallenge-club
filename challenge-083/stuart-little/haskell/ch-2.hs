#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import Data.List (subsequences,)
import Data.List.Extra (minimumOn,groupSortOn,)
import System.Environment (getArgs,)

main = do
  nrs <- getArgs >>= return.(map (read::String->Int))
  let reslst = minimumOn length $ last $ groupSortOn sum $ filter ((<= (sum nrs)).(2*).sum) $ subsequences nrs
  putStrLn "Change the sign(s) of:"
  print reslst
  putStrLn $ "Number of elements: " ++ (show $ length reslst)
