module Challenge270
   where
import Data.List ( transpose , (!!) ) 

solution :: [[Int]] -> Int
solution matrix = min validRows validColumns
 where
  validRows :: Int
  validRows = length $ filter (\i -> (sum $ matrix !! i) == 1) [0..length
   matrix - 1 ]
  validColumns :: Int
  validColumns = length $ filter (\i -> ( sum $ transposed !! i ) == 1 ) 
   [0..length ( matrix !! 0 ) - 1 ]
   where
    transposed = transpose matrix

enterNLines :: Int -> IO [String]
enterNLines n 
   |n <= 0 = return []
   |otherwise = do
      putStrLn "Enter some integers, separated by blanks!"
      x <- getLine
      xs <- enterNLines ( n - 1 )
      let ret = (x:xs)
      return ret   

main :: IO ( ) 
main = do
   putStrLn "Enter a binary matrix of 0 and 1, separated by blanks!"
   putStrLn "How many rows do you want to enter?" 
   numberline <- getLine
   matrix <- enterNLines $ read numberline
   print $ solution ( map ( map read . words ) matrix ) 

