module Challenge234_2
   where
import qualified Data.Set as S

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]

solution :: [Int] -> Int
solution list 
   |length list < 3 = 0
   |otherwise = sum $ map product $ (\li -> map findFreq li) $ combinations 3
    $ S.toList $ S.fromList list
    where
     findFreq :: [Int] -> [Int]
     findFreq sublist = map (\i -> length $ filter (== i ) list ) sublist
   
main :: IO ( ) 
main = do 
   putStrLn "Enter some positive integers, separated by blanks!" 
   numbers <- getLine
   print $ solution $ map read $ words numbers
