module Challenge155_2
  where
import Data.List.Split ( chunksOf )
import Data.List ( (!!) )

fibonacci :: Int -> Int
fibonacci n
  |n == 0 = 0
  |n == 1 = 1
  |n > 1 = fibonacci ( n - 1 ) + fibonacci ( n - 2 )

pisanos :: [Int]
pisanos = map (\i -> mod i 3 ) $ map fibonacci [0 .. 500]

--equal list can be directly compared, the first 2 equal sublists are
--taken to be representative of the entire range of pisano numbers
solution :: Int
solution = length $ head $ head $ filter (\li -> (li !! 0) == ( li !! 1 ) )
$ map (\n -> chunksOf n pisanos) [2 .. 12]
