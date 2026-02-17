module Challenge361_2
   where
import Data.List ( findIndices , (!!) , (\\))

solution :: [[Int]] -> Int
solution matrix = if length zerolines /= 1 then -1 else if all (\row -> row !!
 hz == 1 ) rest then hz else -1
   where
      zerolines :: [Int]
      zerolines = findIndices (\row -> all ( (== 0) ) row ) matrix
      hz        :: Int
      hz        =  head zerolines
      rest      :: [[Int]]
      rest      =  matrix \\ [matrix !! hz]

enterLines :: IO [String]
enterLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> enterLines
   
main :: IO ( )
main = do
   putStrLn "Enter some 0 and 1 , <enter> to end!" 
   allInput <- enterLines
   let matrix = map ( map read . words ) allInput
   print $ solution matrix
