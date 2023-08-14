module Challenge229
   where
import Data.List( sort )

solution :: String -> Int
solution line = length $ filter ( not . isSorted ) $ words line
 where
  isSorted :: String -> Bool
  isSorted s = s == sorted || s == reverse sorted
   where
    sorted :: String
    sorted = sort s

main :: IO ( )
main = do
   putStrLn "Enter some words separated by blanks!" 
   input <- getLine
   print $ solution input
