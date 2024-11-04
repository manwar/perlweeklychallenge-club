module Challenge294
   where
import Data.List.Split ( divvy ) 
import Data.List ( (!! ) , maximumBy , sort ) 

isContiguous :: [Int] -> Bool   
isContiguous list = all (\v -> last v - head v == 1 ) $ divvy 2 1 list

cutFromList :: [Int] -> Int -> Int -> [Int]
cutFromList list from to =  take ( to - from + 1 ) $ drop from list 

findSublists :: [Int] -> [[Int]]
findSublists list = [ cutFromList sorted i j | i <- [0..l - 2] ,
 j <- [i + 1 .. l - 1]]
  where
   l = length list
   sorted = sort list

solution :: [Int] -> Int
solution list =
   let sublists = findSublists list
       selected = filter isContiguous sublists
   in if null selected then -1 else length $ maximumBy(\a b -> compare ( length a ) 
    (length b) ) selected	 

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!" 
   numberstrings <- getLine
   print $ solution $ map read $ words numberstrings
