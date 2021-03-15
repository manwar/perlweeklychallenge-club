#!/usr/bin/env runghc

-- run <script> <low_bound high_bound>

import System.Environment (getArgs,)

isStep nr = all (1==) $ map abs $ zipWith (-) digits $ tail digits
  where digits = map (\x -> read [x]::Int) $ show nr

main = do
  args <- getArgs
  let (low:high:_) = map (read::String->Int) args
  print $ filter isStep [low..high]
  
