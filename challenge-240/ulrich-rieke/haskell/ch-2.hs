module Challenge240_2
   where
import Data.List ( (!!) ) 

solution :: [Int] -> [Int]
solution list = map (\d -> list !! d ) $ map (\i -> list !! i )
 [0..length list - 1]

main :: IO ( )
main = do
   putStrLn "Enter some positive integers, separated by blanks!" 
   putStrLn "Numbers should be between 0 and array length - 1!" 
   numberstrings <- getLine 
   let numbers = map read $ words numberstrings 
   print $ solution numbers
