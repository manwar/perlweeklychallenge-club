module Challenge204
  where
import Data.List.Split ( divvy )

solution :: [Int] -> Int
solution list = if all ( <= 0 ) differences || all ( >= 0 ) differences then 1
else 0
where
  differences :: [Int]
  differences = map (\li -> last li - head li ) $ divvy 2 1 list
