module Challenge153
  where

factorial :: Int -> Int
factorial n
  |n == 0 = 1
  |n > 0 = product [1 .. n]

leftFactorial :: Int -> Int
leftFactorial n = sum $ map factorial [0 .. n - 1]

solution :: [Int]
solution = map leftFactorial [1 .. 10]
