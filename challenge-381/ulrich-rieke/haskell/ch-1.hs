module Challenge381
   where
import Data.List ( transpose , sort )

readLines :: IO [String]
readLines = do
   line <- getLine
   if null line then return []
   else (line :) <$> readLines

condition :: [[Int]] -> Bool
condition matrix = 
   let comparison = [1..length matrix]
       transposed = transpose matrix
   in (all ( == comparison ) $ map sort matrix) && ( all ( == comparison ) $
         map sort transposed )

convert :: [String] -> [[Int]]
convert = map ( map read . words )

main :: IO ( ) 
main = do
   putStrLn "Enter a n x n matrix with numbers from 1 to n!" 
   matrixlines <- readLines
   print $ condition $ convert matrixlines

