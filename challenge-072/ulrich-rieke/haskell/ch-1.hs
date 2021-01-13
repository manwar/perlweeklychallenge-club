module Challenge072
  where

fac :: Int -> Int
fac n = product [1..n]

findFinalZeroes :: Int -> Int
findFinalZeroes n = length $ fst $ span  ('0' ==  ) $ reverse
$ show n

solution :: Int -> Int
solution n = findFinalZeroes $ fac n
