#!/usr/bin/env runghc

{-
run <script> <number>

returns a list of primes that sums to the target
-}

import System.Environment (getArgs,)
import Data.Numbers.Primes (primes,isPrime,)

primeSummands :: Int -> [Int]
primeSummands nr
  |nr<=1 =[]
  |isPrime nr =[nr]
  |isPrime (nr - 2) =[2,nr-2]
  |odd nr = 3:(primeSummands (nr-3))
  |otherwise = [p,nr-p] where
     (p:_) = filter (isPrime.(nr-)) primes

main = do
  nr <- getArgs >>= return.(read::String->Int).head
  print $ primeSummands nr
