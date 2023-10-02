module Challenge222
  where
import Data.List ( sort )

solution :: [Int] -> Int
solution list = length $ filter (\p -> fst p == snd p ) $ zip list ( sort list )
