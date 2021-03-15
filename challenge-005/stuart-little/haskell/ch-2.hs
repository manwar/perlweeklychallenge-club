#!/usr/bin/env runghc

-- run <script> <path-to-dict-file>

import System.Environment (getArgs,)
import Data.List ((\\),)
import Data.Char (toLower,)
import Data.List.Extra (maximumOn,groupSortOn,)
import Data.MultiSet (fromList,)

main = do
  (file:_) <- getArgs
  text <- readFile file
  putStrLn $ unwords $ maximumOn length $ groupSortOn (fromList.(map toLower)) $ words text
