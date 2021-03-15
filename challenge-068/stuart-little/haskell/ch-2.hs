#!/usr/bin/env runghc

-- run <script> <space-separated list entries>

import System.Environment (getArgs,)
import Data.List.Utils (join,)

reorder :: [a] -> [a]
reorder xs
  |length xs <= 2 =xs
  |otherwise =(head xs:l:(reorder m)) where
     (m,(l:_)) = splitAt (length xs - 2) $ tail xs
     
main = do
  args <- getArgs
  putStrLn $ join " -> " $ reorder args
