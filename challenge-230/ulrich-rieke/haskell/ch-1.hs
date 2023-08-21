module Challenge230
   where
import Data.Char ( digitToInt ) 

solution :: [Int] -> [Int]
solution = concat . map decompose
 where
  decompose :: Int -> [Int]
  decompose n = map digitToInt $ show n

main :: IO ( ) 
main = do
   putStrLn "Enter some integers, separated by blanks!" 
   numbers <- getLine
   print $ solution $ map read $ words numbers
