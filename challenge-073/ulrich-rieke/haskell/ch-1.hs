module Challenge073
  where
import Data.List.Split ( divvy )

solution :: Int -> [Int] -> [Int]
solution window list = map minimum $ divvy window 1 list
