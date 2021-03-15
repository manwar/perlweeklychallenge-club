#!/usr/bin/env runghc

-- run <script> <integer> <space-separated list entries>

import System.Environment (getArgs,)
import Data.List.Utils (join,)

main = do
  (nrstr:lst) <- getArgs
  let nr = read nrstr::Int
  putStrLn $ join " -> " $ (\(p,q)-> p ++ (tail q)) $ splitAt (length lst - nr) lst
