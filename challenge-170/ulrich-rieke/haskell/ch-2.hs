module Challenge170_2
  where

createRow :: [Int] -> [Int] -> [Int]
createRow row otherRow = concat $ map (\i -> map ( *i ) otherRow ) row

createBlock :: [Int] -> [[Int]] -> [[Int]]
createBlock row block = map (\line -> createRow row line) block

kronecker :: [[Int]] -> [[Int]] -> [[Int]]
kronecker firstMatrix secondMatrix = concatMap (\line -> createBlock line
secondMatrix ) firstMatrix
