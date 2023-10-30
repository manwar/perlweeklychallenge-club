module Challenge238
   where

solution :: [Int] -> [Int]
solution = scanl1 ( + )
