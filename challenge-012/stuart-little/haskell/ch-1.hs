#!/usr/bin/env runghc

-- run <script>

import Data.Numbers.Primes (primes,isPrime,)

main = do
  print $ head $ dropWhile isPrime $ map (1+) $ scanl1 (*) primes
