#!/usr/bin/env runghc

-- run <script> <string> <path-to-file> where the string contains all of your letters, in any order

import System.Environment (getArgs,)
import Data.List ((\\),)
import Data.Char (toLower,)

main = do
  (llist:file:_) <- getArgs
  content <- readFile file
  mapM_ putStrLn $ filter (\w -> (map toLower w) \\ (map toLower llist) == "") $ lines content
