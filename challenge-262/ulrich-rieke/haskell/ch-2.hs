module Challenge262_2
   where
import Data.List ( nub , ( !! ))

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]   

solution :: [Int] -> Int -> Int
solution list k = length $ filter (\p -> ((list !! (head p )) ==
 (list !! (last p ))) && ( mod ( (head p) * ( last p ) ) k == 0 ) ) 
 $ nub $ combinations 2 [0..length list - 1]

main :: IO ( )
main = do
   putStrLn "Enter some integers , separated by whitespace!"
   numberline <- getLine
   putStrLn "Enter another integer!"
   numberterm <- getLine
   print $ solution ( map read $ words numberline ) ( read numberterm )
 
