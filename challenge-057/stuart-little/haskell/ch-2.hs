#!/usr/bin/env runghc

-- run as <script> <space-separated words>

import System.Environment (getArgs)
import Data.List (isPrefixOf, inits)

uniqPrefs xs = map head $ map (dropWhile (\pref -> (length $ filter (isPrefixOf pref) xs) >= 2)) $ map inits xs

main = do
  args <- getArgs
  putStrLn $ unwords $ uniqPrefs args
