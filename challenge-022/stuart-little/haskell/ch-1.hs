#!/usr/bin/env runghc

-- run <script>

import System.Environment (getArgs,)
import Data.Numbers.Primes (isPrime,primes,)

main = do  
  mapM_ print $ map (\p -> (p,p+6)) $ take 10 $ filter (\p -> isPrime (p+6)) primes
