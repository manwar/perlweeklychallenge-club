#!/usr/bin/env runghc

-- run <script> <nr elements to display; defaults to 50>

import Safe (headDef)
import System.Environment (getArgs)

memo_fusc :: Int -> Integer
memo_fusc = (map fusc [0 ..] !!)
   where fusc 0 = 0
         fusc 1 = 1
         fusc n = if (mod n 2 == 0) then (memo_fusc $ div n 2) else memo_fusc (div (n-1) 2) + memo_fusc (div (n+1) 2)

main = do
  nr <- getArgs >>= return . (read::String->Int) . headDef "50"
  putStrLn $ unwords $ map show $ map memo_fusc [0..nr-1]
