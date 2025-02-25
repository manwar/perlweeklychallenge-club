module Challenge307_2
   where
import Data.List( sort )
import Data.List.Split( divvy ) 

areAnagrams :: String -> String -> Bool
areAnagrams str1 str2 = sort str1 == sort str2

solution :: [String] -> Int
solution input = 
   let neighbours = divvy 2 1 input
       anacount = length $ filter (\subli -> areAnagrams (head subli) (last subli) ) 
        neighbours
   in length input - anacount

main :: IO ( )
main = do 
   putStrLn "Enter some words separated by whitespace!"
   input <- getLine
   print $ solution $ words input
