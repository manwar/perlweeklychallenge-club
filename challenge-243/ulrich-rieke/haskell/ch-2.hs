module Challenge243_2
   where
import Data.List ( (!!) ) 

findPairs :: [Int] -> [(Int , Int) ] 
findPairs list = concat $ map (\i -> map (\el -> (list !! i , el )) $ drop ( i + i ) 
 list ) [0..length list - 2]

solution :: [Int] -> Int
solution list 
   |all (\i -> i == h ) list = h * ( length list )
   |otherwise = length list + ( sum $ map (\p -> div (fst p ) ( snd p) + div
    ( snd p ) ( fst p ) ) suitablePairs ) 
   where
    h :: Int
    h = head list
    suitablePairs :: [(Int , Int ) ]
    suitablePairs = filter (\pa -> fst pa /= snd pa ) $ findPairs list

main :: IO ( )
main = do
   putStrLn "Enter some positive integers >= 1 , separated by blanks!" 
   numberstrings <- getLine
   let numbers = map read $ words numberstrings
   print $ solution numbers
