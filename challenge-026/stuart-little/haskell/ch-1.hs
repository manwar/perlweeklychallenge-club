#!/usr/bin/env runghc

-- run <script> <stones_string> <jewels_string>

import System.Environment (getArgs,)

main = do
  (stones:jewels:_) <- getArgs
  print $ length $ filter (flip elem stones) jewels
