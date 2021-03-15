#!/usr/bin/env runghc

-- run <script> <separator followed by paths, all mutually space-separated>

import System.Environment (getArgs,)
import Data.List (inits,isPrefixOf,)
import Data.List.Split (splitOn,)
import Data.List.Utils (join,)

commDir sep paths = join sep $ last $ takeWhile (\x -> all (isPrefixOf x) splits) $ inits $ splitOn sep $ head paths where
  splits = map (splitOn sep) paths
  
main = do
  (sep:paths) <- getArgs
  putStrLn $ commDir sep paths
