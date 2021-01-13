module Challenge075_2
  where
import Data.List.Split ( divvy )

computeArea :: [Int] -> Int
computeArea list = ( minimum list ) * ( length list )

--compare the area of the total list with the maximum of all the
--groups of neighbouring numbers which are found by grouping 2 to
--l - 1 numbers together ( l being the length of the list )
findMaxArea :: [Int] -> Int
findMaxArea list = max ( computeArea list ) ( maximum $ map computeArea
      neighbours )
  where
      neighbours :: [[Int]]
      neighbours = foldl1 ( ++ )  $ map (\i -> divvy i 1 list)
      [2..length list - 1]
