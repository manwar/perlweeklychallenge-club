module Challenge080
  where
import Data.List ( sort )

solution :: [Int] -> Int
solution list = head $ filter (\i -> not $ elem i theList ) [1 , 2 ..]
  where
      theList :: [Int]
      theList = sort $ filter ( 0 < ) list
