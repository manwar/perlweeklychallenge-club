module Challenge283_2
   where
import Data.List ( (!!) ) 

count :: Eq a => a -> [a] -> Int
count _ [] = 0
count d (x:xs) 
   |d == x = 1 + count d xs
   |otherwise = count d xs

solution :: [Int] -> Bool
solution numbers = all (\(index , number) -> count index numbers == 
 numbers !! index ) $ zip [0 , 1 ..] numbers

main :: IO ( ) 
main = do
   putStrLn "Enter some numbers , separated by blanks!" ;
   numberline <- getLine
   print $ solution $ map read $ words numberline 
