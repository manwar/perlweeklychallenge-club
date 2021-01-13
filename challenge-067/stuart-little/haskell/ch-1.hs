#!/usr/bin/env runghc

-- run <script> <max combinations_size>

import System.Environment (getArgs,)
import Combinatorics (tuples,)

main = do
  (max:size:_) <- getArgs
  mapM_ print $ tuples (read size::Int) [1..read max::Int]
