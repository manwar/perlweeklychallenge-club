module Challenge122
  where

solution :: [Int] -> [Double]
solution list = map(\p -> (fromIntegral $ sum $ take ( snd p ) list ) /
( fromIntegral $ snd p ) ) $ zip list [1 .. length list]
