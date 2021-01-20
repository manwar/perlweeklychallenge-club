#!/usr/bin/env runghc

-- run <script>

import Data.Numbers.Primes (primes,)
import Data.List (transpose,)

sprimes = map (\(x:y:z:_) -> y) $ filter (\(x:y:z:_)-> x+z < 2*y) $ transpose $ take 3 $ iterate tail primes

wprimes = map (\(x:y:z:_) -> y) $ filter (\(x:y:z:_)-> x+z > 2*y) $ transpose $ take 3 $ iterate tail primes

main = do
  let n = 10
  putStrLn ("Strong primes: " ++ (unwords $ map show $ take n sprimes))
  putStrLn ("Weak primes: " ++ (unwords $ map show $ take n wprimes))
