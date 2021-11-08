#!/usr/bin/env runghc

-- run <script> <number>

import Data.Char (digitToInt)
import System.Environment (getArgs)

no1 :: String -> Integer
no1 nr
  |length nr == 0 = 0
  |head nr == '1' = 9^(length nr -1)
  |otherwise = ((toInteger $ digitToInt $ head nr) - 1) * 9^(length nr -1) + (no1 $ tail nr)

adjNo1 :: String -> Integer
adjNo1 nr = if (not $ elem '1' nr) then (no1 nr) else (no1 nr - 1)

main :: IO ()
main = getArgs >>= putStrLn.show.adjNo1.head
