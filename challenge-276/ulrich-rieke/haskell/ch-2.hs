module Challenge276_2
   where
import Data.List ( sort , sortOn , group ) 

solution :: [Int] -> Int
solution list = 
   let sorted = sort list
       grouped = group sorted
       groupedLengths = sortOn length grouped
       maxLen = length $ last groupedLengths -- maximum frequency
       howmany = length $ filter ( (== maxLen ) . length ) grouped --elements with
       --maximum frequency
   in howmany * maxLen --their product    

main :: IO ( )
main = do
   putStrLn "Enter some positive integers, separated by blanks!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline
