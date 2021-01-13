#!/usr/bin/env runghc

-- run <script> <quoted string>

import System.Environment (getArgs,)
import Data.List.Split (chunksOf,)
import Data.List (transpose,)
import Data.Char (toLower,)

main = do
  args <- getArgs
  putStrLn $ unwords $ transpose $ chunksOf 8 $ map toLower $ concat $ words $ args !! 0
