#!/usr/bin/env runghc

-- run <script>

import System.Environment (getArgs,)

main = do
  mapM_ print [(x,y,12-x-y) | x <- [1..10], y <- [1..10], x + y < 12]
