#!/usr/bin/env runghc

-- run <script> <space-separated strings, with the target string first followed by the array entries>

import System.Environment (getArgs,)
import Data.List ((\\),delete,isPrefixOf,)
import Data.List.Extra (headDef,)

splitting :: Eq a => [a] -> [[a]] -> [[[a]]]
splitting str xs
  |xs==[str] =[xs]
  |otherwise = concat $ map (\x -> map (\l -> (x:l)) $ splitting (str \\ x) (delete x xs)) $ filter (\x -> isPrefixOf x str) xs

main = do
  args <- getArgs
  putStrLn $ headDef "0" $ map unwords $ splitting (head args) (tail args)
