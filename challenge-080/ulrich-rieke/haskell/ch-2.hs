module Challenge080_2
  where
import Data.List.Split ( divvy )

solution :: [Int] -> Int
solution list = length list + ( length $ filter (\li -> head li /= last li )
$ divvy 2 1 list )
