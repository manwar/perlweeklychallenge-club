module Main where

import Control.Monad (zipWithM)
import Data.List (elemIndex)

main :: IO ()
main = do
  print $ take 100 pascalTriangle

pascalTriangle :: [[Integer]]
pascalTriangle =
  [1] :
  map
    ( \prev -> 1 : map (uncurry (+)) (pairSlider prev) ++ [1]
    )
    pascalTriangle

pairSlider :: [a] -> [(a, a)]
pairSlider [] = []
pairSlider [_] = []
pairSlider (x : y : xs) = (x, y) : pairSlider (y : xs)