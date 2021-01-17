#!/usr/bin/env runghc

-- run <script> <space-separated strings>

import Data.List (isPrefixOf,inits,)
import System.Environment (getArgs,)

isBase :: Eq a => [a] -> [a] -> Bool
isBase b l = (isPrefixOf l $ cycle b) && (mod (length l) (length b) ==0)

main = do
  (s1:s2:_) <- getArgs
  mapM_ putStrLn $ filter (\p -> and $ map (isBase p) [s1,s2]) $ tail $ inits s1
    
