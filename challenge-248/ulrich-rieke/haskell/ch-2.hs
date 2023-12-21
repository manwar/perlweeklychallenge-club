module Challenge248_2
   where
import Data.List ( intercalate , (!!) ) 
import Data.List.Split ( chunksOf )

getMultipleLines :: Int -> IO [String]
getMultipleLines n
   |n <= 0 = return []
   |otherwise = do
      x <- getLine
      xs <- getMultipleLines ( n - 1 )
      let ret = (x:xs)
      return ret

convert :: [String] -> [[Int]]
convert list = map (\li -> map read $ words li ) list 

printRow :: [Int] -> String
printRow row = "  (" ++ (intercalate ", " $ map show row ) ++ ")"

solution :: [[Int]] -> [[Int]]
solution numberlist = chunksOf ( l - 1 ) [(numberlist !! r !! col) +
 ( numberlist !! r !! (col + 1 ) ) + ( numberlist !! ( r + 1 ) !! col ) +
 ( numberlist !! (r + 1) !! (col + 1 )) | r <- [0..length numberlist - 2] , col <- [0..l
   - 2] ]
  where
   l :: Int
   l = length ( numberlist !! 0 ) 

main :: IO ( )
main = do
   putStrLn "Enter a matrix of an equal number of integers per line!" 
   putStrLn "How many lines do you want to enter?" 
   linenum <- getLine
   numberLines <- getMultipleLines ( read linenum )
   let matrix = convert numberLines
       sums = solution matrix
   putStrLn "(" ;
   mapM_ (\subli -> putStrLn $ printRow subli ) sums
   putStrLn ")" 

