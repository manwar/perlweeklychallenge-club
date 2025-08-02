module Challenge277_2
   where
import Data.List ( nub , ( !! ) ) 

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]  
   
condition :: [Int] -> Bool
condition list = (0 < difference) && ( difference < mini )
 where
  difference = abs ( list !! 0 - list !! 1 )
  mini = minimum list

solution :: [Int] -> Int
solution list = length $ filter condition $ nub $ combinations 2 list

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline

