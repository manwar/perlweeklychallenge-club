module Challenge345
   where
import Data.List ( (!!) ) 

solution :: [Int] -> [Int]
solution list = filter (\i -> and[ list !! i > list !! ( i - 1) , 
 list !! i > list !! ( i + 1 )] ) [1..length list - 2]

main :: IO ( ) 
main = do
   putStrLn "Enter at least 3 integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
