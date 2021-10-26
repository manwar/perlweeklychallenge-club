module Challenge136
  where

log2 :: Int -> Float
log2 n = log (fromIntegral n) / log 2.0

solution :: Int -> Int -> Int
solution m n
  |(realToFrac $ floor theNum) == theNum = 1
  |otherwise = 0
  where
      theNum :: Float
      theNum = log2 $ gcd m n
