#!/usr/bin/env runghc

-- run <script> <string1 string2 target_string>

import System.Environment (getArgs,)
import Data.List.Extra (notNull,)

intertwine :: [a] -> [a] -> [[a]]
intertwine xs ys
  |null xs || null ys = [xs ++ ys]
  |otherwise = (nextIt xs ys ) ++ (nextIt ys xs) where
     nextIt l1 l2 = map ((head l1):) (intertwine (tail l1) l2)
     
main = do
  args <- getArgs
  let (w1:w2:target:_) = args
  putStrLn $ show $ notNull $ filter (target==) $ intertwine w1 w2
