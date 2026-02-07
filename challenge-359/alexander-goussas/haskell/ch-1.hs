module Main where

import           Control.Exception (assert, evaluate)

sumDigits :: Int -> Int
sumDigits n = go n 0
  where
    go 0 s = s
    go n s = go (n `div` 10) (n `mod` 10 + s)

solve :: Int -> (Int, Int)
solve n | n < 10 = (0, n)
solve n = go 0 (sumDigits n)
  where
    go persistence s | s < 10 = (persistence + 1, s)
    go persistence s = go (persistence + 1) (sumDigits s)

main :: IO ()
main = do
  evaluate $ assert ((2, 2) == solve 38) ()
  evaluate $ assert ((0, 7) == solve 7) ()
  evaluate $ assert ((2, 9) == solve 999) ()
  evaluate $ assert ((3, 1) == solve 1999999999) ()
  evaluate $ assert ((1, 3) == solve 101010) ()
