module Challenge241
   where
import Data.List ( (!!) )

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]  

myCondition :: [Int] -> [Int] -> Int -> Bool
myCondition indices list diff = ( (list !! ( indices !! 1 ))  - 
 (list !! ( indices !! 0 )) == diff ) && ( ( list !! ( indices !! 2 )) -
 ( list !! ( indices !! 1 ) ) == diff ) 

main :: IO ( )
main = do
   putStrLn "Enter at least 3 positive integers in ascending order!" 
   numberstrings <- getLine
   putStrLn "Enter a positive integer!"
   diffstring <- getLine
   let numbers = map read $ words numberstrings
       diff    = read diffstring
       allCombis = combinations 3 [0..length numbers - 1]
       selected = filter (\li -> myCondition li numbers diff ) allCombis
   print $ length selected    
