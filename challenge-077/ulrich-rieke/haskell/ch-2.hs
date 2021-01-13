module Challenge077_2
  where
import Control.Applicative
import Data.List ( (!!) , (\\) , findIndices )

--given a row or column index in the array, which is the allowable range
--of neighbouring rows or colums ?
findRange :: (Int , Int ) -> Int -> [Int]
findRange ( lowerLimit , upperLimit ) value
  |value == lowerLimit = [value , value + 1]
  |value > lowerLimit && value < upperLimit = [value - 1 , value , value
    + 1 ]
  |value == upperLimit = [ value - 1 , value ]
  |otherwise = []

--which are the indexes of neighbours to a 'x' in the array
--look at the possible ranges of rows and columns and subtract from that
--the index of the x
findNeighbours :: [String] -> Int -> Int -> [(Int , Int)]
findNeighbours array row column = ((,) <$> (findRange (0 , length array - 1)
row) <*> ( findRange (0 , (length $ head array) - 1 ) column )) \\
  [(row , column)]

findChar :: [String] -> Int -> Int -> Char
findChar array row column = ( array !! row ) !! column

--find the x'es in every row
find_x_Indices :: [String] -> [[Int]]
find_x_Indices array = map (\row -> findIndices ('x' == ) row ) array

--find the neighbouring indices in every line
findAllNeighbourIndices :: [String] -> [[Int]] -> [[(Int , Int)]]
findAllNeighbourIndices array xindices = concat $ map (\p -> map(\i ->
findNeighbours array ( fst p ) i ) (snd p) ) $ zip [0, 1 ..] xindices

--find neighbouring strings
findStrings :: [String] -> [[(Int , Int)]] -> [String]
findStrings array foundIndices = map (\list -> map (\p -> findChar
array ( fst p ) ( snd p ) ) list ) foundIndices


solution :: [String] -> Int
solution array = length $ filter condition allNeighbourStrings
  where
      allXIndices :: [[Int ]]
      allXIndices = find_x_Indices array
      allNeighbourIndices :: [[(Int, Int)]]
      allNeighbourIndices = findAllNeighbourIndices array allXIndices
      allNeighbourStrings :: [String]
      allNeighbourStrings = findStrings array allNeighbourIndices
      condition :: String -> Bool
      condition s = all ('o' == ) s
