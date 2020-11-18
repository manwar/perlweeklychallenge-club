module Challenge087
  where
import Data.List ( sort , sortOn , subsequences )

solution :: [Int] -> [Int]
solution list
  |not $ null orderedSequences = last $ sortOn length orderedSequences
  |otherwise = []
  where
      sortedList :: [Int]
      sortedList = sort list
      orderedSequences :: [[Int]]
      orderedSequences =  filter (\li -> last li ==  (head li + length li - 1 ) )
    $ filter ( ( 1 < ) . length ) $ subsequences sortedList
