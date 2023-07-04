module Challenge223
  where

isPrime :: Int -> Bool
isPrime n
  |n == 2 = True
  |n == 1 = False
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. root]
  where
      root :: Int
      root = floor $ sqrt $ fromIntegral n

solution :: Int -> Int
solution n = length $ filter isPrime [2..n]
