module Challenge145
  where

solution :: [Int] -> [Int] -> Int
solution list1 list2 = sum $ zipWith( * ) list1 list2
