module Main where

main :: IO ()
main = print $ take 1000 regularNumbers

-- https://en.wikipedia.org/wiki/Regular_number#Algorithms
regularNumbers :: [Int]
regularNumbers = 1 : map (2 *) regularNumbers `merge` map (3 *) regularNumbers `merge` map (5 *) regularNumbers

merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x : xs) (y : ys)
  | x == y = x : xs `merge` ys
  | x < y = x : xs `merge` (y : ys)
  | otherwise = y : (x : xs) `merge` ys