#!/usr/bin/env runghc

-- run <script> <space-separated file paths, with an optional -csv flag in front>

import Data.List (partition,sortOn,)
import Data.List.Extra (groupSortOn,)
import System.Environment (getArgs,)
import Text.Printf (printf,)

printHow :: [String] -> (String,Int) -> String
printHow flags (k,v) = if (null flags)
  then (printf "%-20s" k) ++ (show v)
  else k ++ "," ++ (show v)

main = do
  (flags,paths) <- getArgs >>= return.(partition ("-csv"==))
  wrds <- (mapM readFile paths) >>= return.concat.(map words) 
  mapM_ putStrLn $ map (printHow flags) $ sortOn ((0-).snd) $ map (\l -> (head l, length l)) $ groupSortOn id wrds
