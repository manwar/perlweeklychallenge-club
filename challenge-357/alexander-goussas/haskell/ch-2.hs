module Main where

import           Control.Exception (assert, evaluate)
import           Data.List         (nub, sort, tails)
import           Data.Ratio        ((%))

generate :: [Integer] -> [Rational]
generate xs = nub $ sort $ (1 % 1) : concatMap (flip go $ []) (tails xs)
  where
    go :: [Integer] -> [Rational] -> [Rational]
    go (x:y:ys) acc = go (x:ys) (x % y : y % x : acc)
    go _ acc        = acc

main :: IO ()
main = do
  evaluate $ assert (generate [1..3] == [1%3, 1%2, 2%3, 1%1, 3%2, 2%1, 3%1]) ()
  evaluate $ assert (generate [1..4] == [1%4, 1%3, 1%2, 2%3, 3%4, 1%1, 4%3, 3%2, 2%1, 3%1, 4%1]) ()
  evaluate $ assert (generate [1] == [1%1]) ()
  evaluate $ assert (generate [1..6] == [1%6, 1%5, 1%4, 1%3, 2%5, 1%2, 3%5, 2%3, 3%4, 4%5, 5%6, 1%1, 6%5, 5%4, 4%3, 3%2, 5%3, 2%1, 5%2, 3%1, 4%1, 5%1, 6%1]) ()
  evaluate $ assert (generate [1..5] == [1%5, 1%4, 1%3, 2%5, 1%2, 3%5, 2%3, 3%4, 4%5, 1%1, 5%4, 4%3, 3%2, 5%3, 2%1, 5%2, 3%1, 4%1, 5%1]) ()
