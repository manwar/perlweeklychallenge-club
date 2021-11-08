#!/usr/bin/env runghc

-- run <script> <number>

import Data.List((\\))
import System.Environment (getArgs)

nxt :: String -> String
nxt ss = if null ls
  then (take (length ss + 1) $ cycle "12")
  else ((scc ls) ++ (take (length rs) $ cycle "12")) where
  revss = reverse ss
  rev3 = takeWhile ('3'==) revss
  [ls,rs] = map reverse [revss \\ rev3, rev3]
  scc = show . (1+) . (read::String->Int)

main :: IO ()
main = getArgs >>= putStrLn.head.(flip drop (iterate nxt "0")).(read::String->Int).head
