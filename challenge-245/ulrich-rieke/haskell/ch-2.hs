module Challenge245_2
   where
import Data.List ( permutations , sort )

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]      

concatenate :: [Int] -> Int
concatenate list
   |length list == 1 = head list
   |otherwise = read $ foldl1 ( ++ ) $ map show list

solution :: [Int] -> Int
solution list 
   |length sorted == 0 = -1
   |otherwise = last sorted
   where
    possiblePermus = map concatenate $ concat $ map permutations $ concat $ map
     (\i -> combinations i list )[1..length list]
    sorted =  sort $ filter (\n -> mod n 3 == 0 ) possiblePermus 	  

main :: IO ( ) 
main = do
   putStrLn "Please enter some integers greater than 0 , separated by blanks!"
   numberstrings <- getLine 
   let numbers = if length numberstrings == 1 then [read numberstrings]
                 else map read $ words numberstrings
   print $ solution numbers
