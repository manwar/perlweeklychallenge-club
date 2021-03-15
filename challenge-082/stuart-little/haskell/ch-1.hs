#!/usr/bin/env runghc

-- run <script> <two space-separated numbers>

import System.Environment (getArgs,)
  
main = do
  args <- getArgs
  let (n1:n2:_) = map (read::String->Int) args
  print $ filter (\x -> (mod n1 x == 0) && (mod n2 x == 0)) $ take (min n1 n2) [1..]
