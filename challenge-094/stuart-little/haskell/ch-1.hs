#!/usr/bin/env runghc

-- run as <script> <space-separated words>

import System.Environment (getArgs)
import Data.List (sort)
import Data.List.Extra (groupSortOn)

main = do  
  args <- getArgs
  mapM_ putStrLn $ map unwords $ groupSortOn sort $ args
