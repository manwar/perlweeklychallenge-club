module Ch1 where

import Data.List

maxDiff :: [Int] -> Int
maxDiff xs = e - f
  where
    e = (s !! (len-1)) * (s !! (len-2))
    f = head s * (s !! 1)
    len = length s
    s = sort xs

main :: IO ()
main = do
  print $ maxDiff [5,9,3,4,6]
  print $ maxDiff [1,-2,3,-4]
  print $ maxDiff [-3,-1,-2,-4]
  print $ maxDiff [10,2,0,5,1]
  print $ maxDiff [7,8,9,10,10]

