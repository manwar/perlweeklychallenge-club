module Challenge105
  where

solution :: Int -> Int -> Float
solution n k = (fromIntegral k) ** ((fromIntegral 1) / (fromIntegral n))
