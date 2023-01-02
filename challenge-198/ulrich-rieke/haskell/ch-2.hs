module Challenge198_2
  where

isPrime :: Int -> Bool
isPrime n
  |n < 2 = False
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. root]
  where
      root :: Int
      root = floor $ sqrt $ fromIntegral n

solution :: Int -> Int
solution n = length $ filter isPrime [0..n - 1]
