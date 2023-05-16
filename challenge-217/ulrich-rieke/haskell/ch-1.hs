module Challenge217
  where
import Data.List ( sort , (!!) )

solution :: [[Int]] -> Int
solution list = sorted !! 2
where
  sorted :: [Int]
  sorted = sort $ concat list
