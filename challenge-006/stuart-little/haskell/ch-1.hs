#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import System.Environment (getArgs,)
import Data.List.Extra (groupOn,)
import Data.List (sort,)

showInterval :: Show a => [a] -> String
showInterval xs
  |length xs >= 3 = (show h) ++ "-" ++ (show l)
  |length xs == 2 = (show h) ++ "," ++ (show l)
  |otherwise = show h
  where (h,l) = (head xs,last xs)

main = do
  args <- getArgs
  putStrLn $ unwords $ map showInterval $ (map.map) snd $ groupOn fst $ zipWith (\x y -> (y-x,y)) [0..] $ sort $ map (read::String->Int) args
