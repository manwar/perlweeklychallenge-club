#!/usr/bin/env runghc

-- run <script>

import Data.Numbers.Primes (isPrime,primeFactors,)

main = do
  mapM_ print $ filter (isPrime.length.primeFactors) [1..50]
