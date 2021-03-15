module Challenge098_2
  where
import Data.List ( findIndices )

solution :: [Int] -> Int -> Int
solution list number
  |not $ null indexlist = head indexlist
  |otherwise =  length $ takeWhile ( < number  ) list
  where
      indexlist :: [Int]
      indexlist = findIndices ( == number ) list
