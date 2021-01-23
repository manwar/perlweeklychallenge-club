#!/usr/bin/env runghc

-- run <script> <space-separated strings>

import System.Environment (getArgs,)
import Data.List (inits,tails,isInfixOf,)
import Data.List.Extra (maximumOn,)

main = do
  strs <- getArgs
  putStrLn $ maximumOn length $ filter (and.(flip map strs).(isInfixOf)) $ concat $ map tails $ inits $ head strs
