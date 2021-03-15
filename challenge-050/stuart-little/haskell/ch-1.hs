#!/usr/bin/env runghc

-- run <script> <space-separated interval ends>

import System.Environment (getArgs,)
import Data.List (sortOn,)
import Data.List.Split (chunksOf,)
   
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
    let intEnds = chunksOf 2 $ map (read::String->Int) args
    print $ foldr newintv [(last intEnds)] intEnds
