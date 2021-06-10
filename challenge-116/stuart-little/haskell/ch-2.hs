#!/usr/bin/env runghc

-- run <script> <number>

import Data.Char (digitToInt)
import Math.NumberTheory.Roots (isSquare)
import System.Environment (getArgs)

digSqSum :: String -> Int
digSqSum = sum . map (\x-> x*x) . map digitToInt

main :: IO ()
main = getArgs >>= putStrLn . show . fromEnum . isSquare . digSqSum . head
