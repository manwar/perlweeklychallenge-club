#!/usr/bin/env runghc

-- run <script> <number>

import Data.Digits (digits)
import System.Environment (getArgs)

isBinPal :: String -> Int
isBinPal str = fromEnum $ digs == reverse digs where
  digs = digits 2 $ (read::String -> Int) str

main :: IO ()
main = getArgs >>= putStrLn.show.isBinPal.head
