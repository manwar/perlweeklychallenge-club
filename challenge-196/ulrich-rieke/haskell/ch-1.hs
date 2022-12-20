module Challenge196
  where
import Data.List ( subsequences , (!!) )

myRule :: [Int] -> Bool
myRule list = length list == 3 && (((list !! 0 ) < ( list !! 2 )) &&
((list !! 2 ) < ( list !! 1 )))

solution :: [Int] -> [Int]
solution list
  |not $ null solutionlist = head solutionlist
  |otherwise = []
  where
    solutionlist :: [[Int]]
    solutionlist = filter myRule $ subsequences list
