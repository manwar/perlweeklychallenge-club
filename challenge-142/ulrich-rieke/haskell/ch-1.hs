module Challenge142
  where

solution :: Int -> Int -> Int
solution m n = length $ filter (\i -> mod i 10 == n) divisors
  where
      divisors :: [Int]
      divisors = filter (\i -> mod m i == 0 ) [1 .. m]
