#!/usr/bin/env runghc

-- run <script> <target number> <space-separated array entries>

import System.Environment (getArgs,)

main = do
  (df:nrs) <- getArgs >>= return.(map (read::String->Int))
  print $ elem df $ (map (\x->(x-)) nrs) <*> nrs
