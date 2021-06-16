#!/usr/bin/env runghc

-- run <script> <path-to-file>

import Data.Char (isDigit)
import Data.List ((\\))
import System.Environment (getArgs)

missingNr :: [String] -> Int
missingNr xs = head $ [1..(length xs)] \\ lnnrs where
  lnnrs = map (read::String->Int) $ map (takeWhile isDigit) $ map (dropWhile (not . isDigit)) xs

main :: IO ()
main = getArgs >>= readFile . head >>= putStrLn . show . missingNr . lines 
