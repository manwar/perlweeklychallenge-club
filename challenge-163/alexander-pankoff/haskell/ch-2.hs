module Main where

main :: IO ()
main = print $ summations [1 .. 5]

summations :: [Int] -> Int
summations [] = 0
summations [x] = x
summations (_ : xs) = summations $ scanl1 (+) xs