module Challenge309
   where
import Data.List.Split ( divvy ) 
import Data.List ( sortOn ) 

solution :: [Int] -> Int
solution = last . head . sortOn (\subli -> last subli - head subli ) . divvy 2 1

main :: IO ( )
main = do
   putStrLn "Enter some integers in ascending order separated by whitespace!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline
