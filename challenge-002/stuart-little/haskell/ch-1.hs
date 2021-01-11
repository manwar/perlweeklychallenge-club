#!/usr/bin/env runghc

-- run <script> <integer>

import System.Environment (getArgs,)

main = do
  (nr:_) <- getArgs
  putStrLn $ show (read nr::Int)
