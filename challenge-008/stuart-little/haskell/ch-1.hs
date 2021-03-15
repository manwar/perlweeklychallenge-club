#!/usr/bin/env runghc

-- run <script>

import Data.Numbers.Primes (primes,isPrime,)

main = do
  print $ take 5 $ map (\x -> x*(div (x+1) 2)) $ filter isPrime $ map (\p -> 2^p-1) primes
