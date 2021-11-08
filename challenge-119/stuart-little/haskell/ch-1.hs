#!/usr/bin/env runghc

-- run <script> <number>

import Data.Bits ((.&.), shiftR)
import Data.Char (digitToInt, intToDigit)
import Data.Digits (digits, unDigits)
import System.Environment (getArgs)
import Text.Printf (printf)

truncBin :: Int -> Int -> String
truncBin d n = printf ("%0" ++ (show d) ++ "s") $ map intToDigit $ digits 2 $ (.&.) n (2^d-1)

main = do
  nr <- getArgs >>= return.(read::String->Int).head
  let rght = truncBin 4 nr
      lft = truncBin 4 $ shiftR nr 4 
  putStrLn $ show $ unDigits 2 $ map digitToInt $ rght ++ lft
    
