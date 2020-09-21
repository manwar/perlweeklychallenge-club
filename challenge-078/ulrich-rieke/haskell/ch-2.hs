module Challenge078_2
  where

leftRotate :: [Int] -> Int -> [Int]
leftRotate list rotateBy = drop rotateBy list ++ take rotateBy list

solution :: [Int] -> [Int] -> [[Int]]
solution list indices = map (\i -> leftRotate list i ) indices
