#!/usr/bin/env runghc

-- run <script> <quoted string> <number>

import Data.Char (ord,chr,)
import System.Environment (getArgs,)

shiftCaps :: Int -> Char -> Char
shiftCaps n c
  |elem c ['A'..'Z'] = chr $ ord 'A' + mod ((ord c -ord 'A') - (mod n 26)) 26
  |otherwise =c   

rot :: Int -> String -> String
rot n str = map (shiftCaps n) str

main = do
  (str,shift) <- getArgs >>= return.(\(x:y:_)->(x,(read::String->Int) y))
  putStrLn $ rot shift str
