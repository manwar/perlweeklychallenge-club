module Challenge051
  where
import Data.List ( sort , subsequences )

findTriplets :: Int -> [Int] -> [[Int]]
findTriplets theSum list = filter (\li -> sum li == theSum ) $ filter ( (3 == ) . length )
  $ subsequences sorted
  where
      sorted = sort list
