module Challenge244_2 
   where
import Data.List ( (!!) ) 

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]    

solution :: [Int] -> Int
solution list = (sum $ map (\i -> i ^ 2 * i ) list) + (sum $ map (\subli ->
 (maximum subli) ^ 2 * minimum subli ) $ concat $ map (\n -> combinations 
 n list ) [2..length list] )   

main :: IO ( ) 
main = do
   putStrLn "Enter some integers, separated by blanks!" 
   numberstrings <- getLine 
   let numbers = map read $ words numberstrings
   print $ solution numbers
