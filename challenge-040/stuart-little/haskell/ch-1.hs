#!/usr/bin/env runghc

-- run <script> <space-separated strings, quoted if they contain special characters; each string's characters are the entries of one array>

import System.Environment (getArgs,)
import Data.List (transpose,)

main = do
  args <- getArgs
  mapM_ putStrLn $ transpose args
