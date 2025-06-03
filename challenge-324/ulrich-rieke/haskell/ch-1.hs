module Challenge324
   where
import Data.List.Split ( chunksOf ) 

solution :: [Int] -> Int -> Int -> [[Int]]
solution list rows columns
   |rows * columns /= length list = error "rows and columns don't fit array"
   |otherwise = chunksOf columns list

main :: IO ( ) 
main = do 
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   putStrLn "Enter number of rows and columns!"
   dimline <- getLine
   let ( rows , cols ) = (read $ head $ words dimline , read $ last $
	 words dimline )
   print $ solution ( map read $ words numberline ) rows cols
