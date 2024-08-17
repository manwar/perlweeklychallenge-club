module Challenge276
   where
import Data.List ( nub , (!!) ) 

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]  

solution :: [Int] -> Int
solution list = length $ filter (\subli -> mod ( sum subli ) 24 == 0 ) $ nub $
 combinations 2 list

main :: IO ( ) 
main = do
   putStrLn "Enter some positive integers, separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
