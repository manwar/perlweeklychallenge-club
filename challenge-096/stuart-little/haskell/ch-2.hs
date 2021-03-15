#!/usr/bin/env runghc

{-
run <script> <space-separated strings>

implements the simple-minded recursion described at
https://en.wikipedia.org/wiki/Edit_distance#Computation
-}

import System.Environment (getArgs,)

levDist :: Eq a => [a] -> [a] -> Int
levDist s1 s2 = d (length s1) (length s2) where
  d :: Int -> Int -> Int
  d x y |x*y == 0 =x+y
  d x y = let extraTerm = if (s1 !! (x-1) == s2 !! (y-1)) then 0 else 1
          in minimum [(1+d (x-1) y),(1+d x (y-1)),(extraTerm + d (x-1) (y-1))]

main = do
  (s1:s2:_) <- getArgs
  print $ levDist s1 s2
