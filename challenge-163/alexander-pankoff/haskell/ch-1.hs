module Main where

import Data.Bits ((.&.))
import Data.List (subsequences)

main :: IO ()
main = print $ sumBitwiseOperator [1 .. 3]

sumBitwiseOperator :: [Int] -> Int
sumBitwiseOperator = sum . map (uncurry (.&.)) . uniquePairs

uniquePairs :: [a] -> [(a, a)]
uniquePairs = map (\[a, b] -> (a, b)) . combinations 2

combinations :: Int -> [a] -> [[a]]
combinations k = filter ((== k) . length) . subsequences
