module Challenge207_2
  where
import Data.List ( sortBy , (!!) )

solution :: [Int] -> Int
solution citations = maximum filtered
where
  myComparator :: Int -> Int -> Ordering
  myComparator a b
  |a > b = LT
  |a == b = EQ
  |a < b = GT
  sortedCitations :: [Int]
  sortedCitations = sortBy myComparator citations
  filtered :: [Int]
  filtered = filter (\i -> sortedCitations !! (i - 1 ) >= i ) [1..length
  citations ]
