module Challenge153_2
  where
import Data.Char ( digitToInt )

factorial :: Int -> Int
factorial n
  |n == 0 = 1
  |n > 0 = product [1 .. n]

solution :: Int -> Int
solution n = if myCondition n then 1 else 0
where
  myCondition :: Int -> Bool
  myCondition num = sum (  map ( factorial . digitToInt ) $ show num ) == num
