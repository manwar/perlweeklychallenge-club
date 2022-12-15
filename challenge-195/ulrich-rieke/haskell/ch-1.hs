module Challenge195
  where
import Data.List ( group, sort )

isSpecial :: Int -> Bool
isSpecial n
  |n < 10 = True
  |otherwise = all (\li -> length li == 1 ) $ group $ sort $ show n

solution :: Int -> Int
solution n = length $ filter isSpecial [1..n]
