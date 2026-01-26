module Main where

import           Control.Exception (assert, evaluate)
import           Data.List         (foldl1, sort)
import           Debug.Trace       (trace)
import           System.IO         (getContents)

-- See https://en.wikipedia.org/wiki/6174 for more on Kaprekar's routine.

iter :: String -> Int
iter (x:xs) | all (==x) xs = -1
iter n = go n 0
  where
    go "6174" c = c
    go n c      = go (compute $ (take (4 - length n) $ repeat '0') ++ n) (c + 1)

compute :: String -> String
compute n =
  let a = sort n
      b = reverse a
  in show . (foldl1 (flip (-))) . sort . (map read) $ [a, b]

main :: IO ()
main = do
  evaluate $ assert (iter "3524" == 3) ()
  evaluate $ assert (iter "6174" == 0) ()
  evaluate $ assert (iter "9998" == 5) ()
  evaluate $ assert (iter "1001" == 4) ()
  evaluate $ assert (iter "9000" == 4) ()
  evaluate $ assert (iter "1111" == -1) ()
