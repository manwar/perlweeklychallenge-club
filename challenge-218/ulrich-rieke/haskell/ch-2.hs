module Challenge218_2
  where
import Data.List ( (!!) , transpose , sortOn )
import Control.Monad.State.Lazy

toggle :: [Int] -> [Int]
toggle list = map (\n -> if n == 1 then 0 else 1 ) list

to_row_sum :: [Int] -> Int
to_row_sum list = sum $ map (\i -> 2 ^ i * ( list !! (l - i - 1)))
[0..l - 1]
where
  l :: Int
  l = length list

do_all_toggles :: [[Int]] -> [[[Int]]]
do_all_toggles matrix = map (\i -> toggleRow i matrix) [0..length matrix - 1]
++ map (\n -> toggleColumn n matrix ) [0..(length ( matrix !! 0 ) - 1)]
  where
  toggleRow :: Int -> [[Int]] -> [[Int]]
  toggleRow aRow aMatrix =  map (\i -> if i == aRow then
    toggle ( matrix !! i ) else matrix !! i ) [0..length aMatrix - 1]

toggleColumn :: Int -> [[Int]] -> [[Int]]
toggleColumn column matrix = transpose $ map (\i -> if i == column then toggle
( transposed !! i ) else transposed !! i ) [0..length transposed - 1]
  where
    transposed :: [[Int]]
    transposed = transpose matrix

find_maximum_toggle :: [[[Int]]] -> (Int , [[Int]])
find_maximum_toggle allTogglings = last $ sortOn fst $ map (\aMatrix ->
  (matrixSum aMatrix , aMatrix )) allTogglings
  where
    matrixSum :: [[Int]] -> Int
    matrixSum someMatrix = sum $ map to_row_sum someMatrix

findMaxSum :: State ((Int , [[Int]] ),[Int] ) Int
findMaxSum = do
  ((maxVal , matrix) , allmaxima) <- get
  let l = length allmaxima
  if l > 1 && (allmaxima !! ( l - 1 )) < ( allmaxima !!
    ( l - 2 ))
  then
      return $ allmaxima !! (l - 2)
  else do
      let (m , toggles ) = find_maximum_toggle $ do_all_toggles matrix
      put (( m , toggles ) , allmaxima ++ [m] )
      findMaxSum

solution :: [[Int]] -> Int
solution input
  |length input == 1 = to_row_sum $ toggle $ input !! 0
  |otherwise =  evalState findMaxSum ( find_maximum_toggle $
    do_all_toggles input , [] )
