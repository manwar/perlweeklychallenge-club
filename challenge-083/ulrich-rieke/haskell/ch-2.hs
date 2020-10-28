module Challenge083_2
  where
import Data.List ( subsequences )

solution :: [Int] -> Int
solution list = secondpart - firstpart
  where
      theSum :: Int
      theSum = sum list
      limit :: Int
      limit = div theSum 2
      smaller :: [ Int ]
      smaller = filter ( limit >= ) list
      firstpart :: Int
      firstpart = if elem limit smaller then limit else maximum $ filter
      ( limit >= ) $ map sum $ subsequences smaller
      secondpart :: Int
      secondpart = theSum - firstpart
