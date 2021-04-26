module Challenge109
  where

chowladivisors :: Int -> [Int]
chowladivisors n
  |n `elem` [1 , 2 , 3] = []
  |otherwise = [d | d <- [2 .. n - 1] , mod n d == 0 ]

solution :: [Int]
solution = take 20 $ map ( sum . chowladivisors) [1,2..]
