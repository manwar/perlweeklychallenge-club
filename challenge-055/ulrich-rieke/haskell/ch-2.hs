module Challenge055_2
  where
import Data.List.Split ( divvy )
import Data.List ( permutations , (!!) )

wavyLists :: [Int] -> [[Int]]
wavyLists list = filter myCondition $ permutations list

myCondition :: [Int] -> Bool
myCondition sublist = all numbersteps $ zip doublets [0,1..]
where
  doublets = divvy 2 1 sublist
  numbersteps :: ([Int] , Int ) -> Bool
  numbersteps ( li , num )
  |even num = li !! 0 >= li !! 1
  |odd num  = li !! 0 <= li !! 1
