#!/usr/bin/env runghc

-- run <script> <string1> <string2>

import Combinatorics (tuples)
import System.Environment (getArgs)

main = do
  (s1:s2:_) <- getArgs
  print $ length $ filter (s2==) $ tuples (length s2) s1
