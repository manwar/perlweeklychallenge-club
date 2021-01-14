#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import System.Environment (getArgs,)
import Data.List (subsequences,)

charTr :: Int -> Int -> Char
charTr lnr val
  |val <= lnr = ' '
  |otherwise = '#'

histLine :: [Int] -> Int -> String
histLine xs lnr = map (charTr lnr) xs

prettyPrintHist :: [Int] -> [String]
prettyPrintHist xs = reverse $ map (histLine xs) [0..(maximum xs - 1)]

main = do
  nrs <- getArgs >>= return.(map (read::String->Int))
  putStrLn $ (replicate 40 '-') ++ "\nHistogram:\n"
  mapM_ putStrLn $ prettyPrintHist nrs
  putStrLn $ (replicate 40 '-') ++ "\nLargest rectangle area: " ++ (show $ maximum $ map (\l-> (length l)*(minimum l)) $ tail $ subsequences nrs) ++ "\n" ++ (replicate 40 '-')
