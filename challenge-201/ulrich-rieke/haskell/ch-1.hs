module Challenge201
  where

solution :: [Int] -> [Int]
solution list = filter (\n -> not $ elem n list ) [0..length list]
