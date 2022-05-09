module Main where

import Data.Char (toLower)
import Data.List (sortBy)

main :: IO ()
main =
  interact
    ( unlines
        . sortBy (\a b -> length a `compare` length b)
        . filter isAbcderian
        . words
    )

isAbcderian :: String -> Bool
isAbcderian = isInAscendingOrder . lc

isInAscendingOrder :: Ord a => [a] -> Bool
isInAscendingOrder = and . (zipWith (<=) <*> tail)

lc :: String -> String
lc = map toLower
