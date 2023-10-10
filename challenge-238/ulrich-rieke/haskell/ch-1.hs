module Challenge238
   where

solution :: [Int] -> [Int]
solution list = map (\n -> sum $ take n list ) [1..length list]
