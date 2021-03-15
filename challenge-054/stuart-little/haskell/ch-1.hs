#!/usr/bin/env runghc

-- run <script> <number of integers to permute> <rank of the permutation>

import System.Environment (getArgs,)

fct n = last $ take (n+1) (1:(scanl1 (*) [1..]))

kthPerm k xs
  |(k <= 1) || (null xs) = xs
  |k >= (fct (length xs)) = reverse xs
  |otherwise = (x:(kthPerm k' (left ++ right)))
   where
     fact = fct (length xs -1)
     idx = div (k-1) fact -- + min 1 (mod k fact)
     k' = k - idx*fact
     (left, (x:right)) = splitAt idx xs
   
main = do
  args <- getArgs
  let (n:k:_) = map (read::String->Int) args
  putStrLn $ unwords $ map show $ kthPerm k [1..n]
