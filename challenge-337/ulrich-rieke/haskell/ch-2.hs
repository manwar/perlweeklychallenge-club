module Challenge337_2
   where
import Data.Char ( digitToInt ) 
import Data.List.Split ( chunksOf ) 
import Data.List ( (!!) , transpose , findIndices) 

parseEntryLine :: String -> [(Int , Int)]
parseEntryLine line = map (\i -> ( digitToInt (line !! (i + 1 )) , digitToInt (line !!
 (i + 3 )))) $ findIndices ( == '[' ) line
   
createMatrix :: Int -> Int -> [[Int]]
createMatrix rows cols = chunksOf cols $ replicate ( rows * cols ) 0

changeRow :: [[Int]] -> Int -> [[Int]]
changeRow matrix row
   |row == 0 = [map succ ( matrix !! 0 )] ++ drop 1 matrix
   |row > 0 && row < l = take row matrix ++ [map succ ( matrix !! row )] ++ drop ( row + 1 ) 
                          matrix
   |row == l = take ( l - 1 ) matrix ++ [ map succ $ last matrix ] 
    where
     l :: Int
     l = length matrix

changeColumn :: [[Int]] -> Int -> [[Int]]
changeColumn matrix col = transpose $ changeRow (transpose matrix ) col 

changeMatrix :: [[Int]] -> (Int , Int) -> [[Int]]
changeMatrix matrix location =
   let afterRowChange = changeRow matrix ( fst location ) 
       afterColChange = changeColumn afterRowChange ( snd location ) 
   in afterColChange
  
solution :: [[Int]] -> [(Int , Int)] -> [[Int]]
solution matrix locations = foldl changeMatrix matrix locations 

main :: IO ( ) 
main = do
   putStrLn "Enter the number of rows and columns in the matrix separated by blanks!"
   dimline <- getLine
   putStrLn "Enter the locations as a list of bracketed positions( separated by commas! )" 
   locationline <- getLine
   let locations = parseEntryLine locationline
       dimensions = map read $ words dimline
       startmatrix = createMatrix ( dimensions !! 0 ) ( dimensions !! 1 )
       finalMatrix = solution startmatrix locations
   print $ length $ filter odd $ concat finalMatrix    
