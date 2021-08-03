#!/usr/bin/env runghc

-- run as <script> <number $n> to return the first $n ugly numbers

import System.Environment (getArgs,)
import Data.List.Ordered (merge,nub,)

smth = let primes=[2,3,5]
  in nub (1:(foldl1 merge $ map (\x -> map (x*) $ nub $ smth) primes))

main = do
  (nr:_) <- getArgs
  mapM_ putStrLn $ map show $ take (read nr::Int) $ smth
