#!/usr/bin/env runghc

{-
run as <script> <space-separated interval ends, with the extra interval coming first>

e.g. <script> 2 6 1 4 8 10 for the first example at

https://perlweeklychallenge.org/blog/perl-weekly-challenge-092/
-}

import System.Environment   
import Data.List  
import Data.List.Split

mrg :: Ord a => [a] -> [a] -> [a]
mrg x y = [(min (head x) (head y)), (max (last x) (last y))]

intp :: Ord a => [a] -> [a] -> Bool
intp x y = ((last y <= last x) && (last y >= head x)) || ((last x <= last y) && (last x >= head y))

newintv :: Ord a => [a] -> [[a]] -> [[a]]
newintv x xs = sortOn head (new:old)
  where old = filter (not . intp x) xs
        new = foldr mrg x $ filter (intp x) xs

main = do  
    args <- getArgs
    let intEnds = chunksOf 2 (map (read::String->Int) args)
    print $ newintv (head intEnds) (tail intEnds)
