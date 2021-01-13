#!/usr/bin/env runghc

-- run <script> <matrix_size>

import System.Environment (getArgs,)

main = do
  args <- getArgs
  let (n:_) = map (read::String->Int) args
  mapM_ print $ take n $ iterate (\x -> (last x):(init x)) (1:(replicate (n-1) 0))
