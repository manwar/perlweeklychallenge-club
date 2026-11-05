module Main where

import           Control.Exception (assert, evaluate)

mean :: [Int] -> Int
mean [] = 0
mean xs = sum xs `div` length xs

solve :: [Int] -> Int
solve =  mean . filter (\x -> even x && x `mod` 3 == 0)

main :: IO ()
main = do
  evaluate $ assert (solve [18, 5, 7, 11] == 18) ()
  evaluate $ assert (solve [6, 12, 18, 24, 30, 40] == 18) ()
  evaluate $ assert (solve [3, 9, 15, 21, 27] == 0) ()
  evaluate $ assert (solve [6, 12, 14, 20] == 9) ()
  evaluate $ assert (solve [6, 6, 6, 12, 12] == 8) ()
