module Challenge126
  where

solution :: Int -> Int
solution n = length $ filter (\s -> not $ elem '1' s ) $ map show [1..n]
