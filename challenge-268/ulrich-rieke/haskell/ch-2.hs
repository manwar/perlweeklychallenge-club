module Challenge268_2
   where
import Data.List ( sort )
import Data.List.Split ( chunksOf ) 

solution :: [Int] -> [Int] 
solution = concat . map reverse . chunksOf 2 . sort 

main :: IO ( )
main = do
   putStrLn "Enter an even number of integers, separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
