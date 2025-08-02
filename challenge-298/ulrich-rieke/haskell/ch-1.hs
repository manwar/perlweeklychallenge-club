module Challenge298
   where
import Data.List ( (!!) , sortOn )
import Control.Applicative 

extraxtSubmatrix :: [[Int]] -> Int -> Int -> Int -> [Int]
extraxtSubmatrix matrix row column sidelength =
   let matrixlen = length matrix
       rowlen = length $ head matrix
       pairs = (,) <$> [row..row + sidelength - 1] <*> [column..column
        + sidelength - 1]
   in map (\p -> matrix !! ( fst p ) !! ( snd p ) ) pairs	

findSquares :: [[Int]] -> Int -> Int -> [[Int]]
findSquares matrix row column = 
   let matrixlen = length matrix
       rowlen = length $ head matrix
       mini = min (matrixlen - row ) (rowlen - column) 
       selected = map (\i -> extraxtSubmatrix matrix row column i ) 
        [1..mini]
   in selected  
    
makeMatrix :: [String] -> [[Int]] 
makeMatrix pack = map (\line -> map read $ words line ) pack

findAllSquares :: [[Int]] -> [[Int]]
findAllSquares pack = 
   let matrixlen = length pack
       rowlen = length $ head pack
   in concat $ [findSquares pack r c | r <- [0..matrixlen - 1] , c <- [0 ..
    rowlen - 1]]

findSquaresSum :: [[Int]] -> Int
findSquaresSum allSquares = 
   let relevantLists = filter (\subli -> all ( == 1 ) subli ) allSquares 
       sorted = if not $ null relevantLists then sortOn length 
        relevantLists else []
   in if null sorted then 0 else length $ last sorted

enterLines :: IO [String]
enterLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> enterLines   

main :: IO ( ) 
main = do
   putStrLn "Enter some 0 and 1 separated by whitespace!" 
   putStrLn "Enter <return> to end!" 
   numberlines <- enterLines
   let matrix = makeMatrix numberlines
       allSquares = findAllSquares matrix
   print $ findSquaresSum allSquares    
