#!/usr/bin/env runghc

-- run <script> <number>

import System.Environment (getArgs,)
import Data.List (intersect,)
import Data.List.Extra (notNull,)

main = do
  nr <- getArgs >>= return.(read::String->Int).head
  print $ head $ dropWhile (notNull.(intersect ['2'..'9']).show) [nr,2*nr..]
