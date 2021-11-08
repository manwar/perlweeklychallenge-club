#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import Combinatorics (tuples)
import Data.List ((\\), )
import Data.List.Extra (minimumOn)
import System.Environment (getArgs)

splt :: (Eq a,Num a,Ord a) => [a] -> [[a]]
splt xs = minimumOn (\p-> abs ((sum $ head p)-(sum $ last p))) $ map (\tp-> [tp, xs\\tp]) $ tuples (div (length xs) 2) xs

main :: IO ()
main = getArgs >>= putStrLn . unlines . map unwords . (map.map) show . splt . map (read::String->Int)
