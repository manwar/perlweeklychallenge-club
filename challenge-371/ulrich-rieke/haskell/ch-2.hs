module Challenge371_2
   where
import Data.List ( (!!) )

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]  

solution :: [Int] -> [[Int]]
solution numbers = 
   let zipped = zip [1 , 2 .. ] numbers
       allCombis = concat [combinations i zipped | i <- [2..length numbers - 1]]
       selected = filter (\subli -> ( sum $ map fst subli ) == ( sum $ map snd subli ))
         allCombis
   in map (\subli -> map snd subli ) selected 

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks" 
   numberline <- getLine
   print $ solution $ map read $ words numberline
