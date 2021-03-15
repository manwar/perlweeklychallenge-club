#!/usr/bin/env runghc

-- run <script> <path-to-file>

import Data.Digits (unDigits,)
import Data.List (union,isInfixOf,)
import Data.List.Split (splitOn,)
import System.Environment (getArgs,)

main = do
  inpt <- getArgs >>= return.head >>= readFile >>= return.
    length.
    (foldl1 union).
    (map (\l -> [(head l)..(last l -1)])).
    ((map.map) (unDigits 60)).
    ((map.map.map) (read::String->Int)).
    ((map.map) (splitOn ":")).
    (map (filter (\w -> or $ map (flip isInfixOf w) (map (\c -> (':':[c])) ['0'..'9'])))).
    (map words).
    lines
  print inpt
