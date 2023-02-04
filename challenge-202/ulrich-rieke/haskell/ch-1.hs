module Challenge202
  where
import Data.List.Split ( divvy )

solution :: [Int] -> Int
solution list = if any (\li -> all odd li ) $ divvy 3 1 list then 1 else 0
