module Challenge144_2
  where
import Data.List ( sort , subsequences )

count :: Eq a => [a] -> a -> Int
count list num = length $ filter ( (== num) ) list

addUlam :: [Int] -> [Int]
addUlam list
  |length list == 2 = list ++ [sum list]
  |otherwise = list ++ [head $ filter (\s -> (count sums s == 1) &&
    s > last list) sums]
  where
      sums :: [Int]
      sums = sort $ map sum $ filter ( (== 2 ) . length ) $ subsequences list

solution :: Int -> Int -> [Int]
solution u v = head $ dropWhile( (< 10 ) . length ) $ iterate
addUlam [u , v]
