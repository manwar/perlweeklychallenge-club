module Challenge243
   where
import Data.List ( (!!) ) 

findGreater :: [Int] -> Int -> Int
findGreater list index = length $ filter (\n -> (list !! index ) > ( 2 * n ) )
 $ drop (index + 1 ) list    

solution :: [Int] -> Int
solution list = sum $ map (\i -> findGreater list i ) [0..length list - 2]

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!" 
   numberstrings <- getLine
   let numbers = map read $ words numberstrings
   print $ solution numbers
