module Challenge197
  where

solution :: [Int] -> [Int]
solution list = filter ( /= 0 ) list ++ ( filter ( == 0 ) list )
