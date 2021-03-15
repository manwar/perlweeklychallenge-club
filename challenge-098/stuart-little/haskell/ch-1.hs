#!/usr/bin/env runghc

-- run <script> <path-to-file> <number>

import System.Environment (getArgs)

main = do
  (path:nr:_) <- getArgs
  txt <- readFile path
  putStrLn $ take (read nr::Int) txt
