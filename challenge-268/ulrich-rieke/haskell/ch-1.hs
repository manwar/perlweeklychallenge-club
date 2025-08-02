module Challenge268
   where
import Data.List ( sort )

solution :: [Int] -> [Int] -> [Int]
solution firstList secondList =
   let firstSorted = sort firstList
       secondSorted = sort secondList
       pairs = zip firstSorted secondSorted 
       comp = snd ( head pairs ) - fst ( head pairs )
   in if all (\p -> snd p - fst p == comp ) pairs then [comp] else []

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by blanks!" 
   firstLine <- getLine
   putStrLn "Enter the same number of integers, separated by blanks!"
   secondLine <- getLine
   let firstNums = map read $ words firstLine
       secondNums = map read $ words secondLine
       result = solution firstNums secondNums
   if not $ null result then print $ head result else print " "    
