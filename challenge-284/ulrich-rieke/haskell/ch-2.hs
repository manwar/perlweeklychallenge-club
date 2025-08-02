module Challenge284_2
   where
import qualified Data.Set as S
import Data.Maybe ( fromJust ) 
import Data.List ( sort , (\\) ) 

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d (x:xs)
   |d == x = 1 + count d xs
   |otherwise = count d xs

findResult :: [Int] -> [Int] -> [Int]
findResult firstList secondList =
   let firstNumbers = S.toList $ S.fromList firstList
       secondNumbers = S.toList $ S.fromList secondList
       frequencies = map (\i -> ( i , count i firstList )) firstList
       onlyFirst = firstNumbers \\ secondNumbers 
       firstPart = concat $ map (\i -> replicate ( fromJust $ lookup i 
		frequencies ) i ) secondList
       secondPart = concat $ map (\i -> replicate ( fromJust $ lookup i 
		frequencies ) i ) $ sort onlyFirst
   in firstPart ++ secondPart

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!" 
   firstLine <- getLine
   putStrLn "Enter some unique integers that are a subset of above!"
   secondLine <- getLine
   let firstNumbers = map read $ words firstLine
       secondNumbers = map read $ words secondLine
   print $ findResult firstNumbers secondNumbers    
