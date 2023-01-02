module Challenge198
  where
import Data.List.Split( divvy )
import Data.List( sort , findIndices )

solution :: [Int] -> Int
solution list
  |length list < 2 = 0
  |otherwise = length $ findIndices ( == maxDiff ) differences
  where
    differences :: [Int]
    differences =  map (\li -> last li - head li ) $ divvy 2 1 $ sort list
    maxDiff :: Int
    maxDiff = maximum differences
