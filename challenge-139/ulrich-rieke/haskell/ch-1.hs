module Challenge139
  where
import Data.List ( sort )

solution :: [Int] -> Int
solution list
  |sort list == list = 1
  |otherwise = 0
