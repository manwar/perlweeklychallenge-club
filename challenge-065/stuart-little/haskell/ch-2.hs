#!/usr/bin/env runghc

{-
Due to the ambiguity I am choosing to interpret the task literally: 'partition' means  splitting into strings that (a) are disjoint, and (b) completely cover the original string.

So I will find all partitions in this sense.

run <script> <string>
-}

import System.Environment (getArgs,)
import Data.List ((\\),inits,reverse,)

palPart :: String -> [[String]]
palPart str
  |null str =[]
  |str == reverse str =(l++[[str]])
  |otherwise =l
   where l=concat $ map (\x -> map (x:) $ palPart (str \\ x)) $ filter (\x -> x == reverse x) $ tail $ inits str

main = do
  (str:_) <- getArgs
  mapM_ putStrLn $ map unwords $ palPart str 
