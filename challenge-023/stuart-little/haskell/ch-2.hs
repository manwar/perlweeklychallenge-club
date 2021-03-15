#!/usr/bin/env runghc

-- run <script> <number>

import System.Environment (getArgs,)
import Data.Numbers.Primes (primeFactors,)

main = do
  (nr:_) <- getArgs
  print $ primeFactors (read nr::Int)
