module Challenge106
  where
import Data.List.Split ( divvy )
import Data.List ( sort )

solution :: [Int] -> Int
solution list
  |length list == 1 = 0
  |otherwise = maximum $ map (\l -> last l - head l ) $ divvy 2 1 $ sort list
