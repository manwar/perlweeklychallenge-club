module Challenge316_2
   where
import Data.List ( findIndices )
import Data.List.Split( divvy )
import Control.Applicative 

isConsecutive :: [Int] -> [Int] -> Bool
isConsecutive firstList secondList = any (\p -> snd p > fst p ) allPairs
   where
    allPairs = (,) <$> firstList <*> secondList

solution :: String -> String -> Bool
solution shorter longer =
   let occurrences = map (\c -> findIndices (== c ) longer ) shorter
       pairs = divvy 2 1 occurrences
   in and $ map(\subli -> isConsecutive ( head subli ) ( last subli ) ) pairs    

main :: IO ( )
main = do
   putStrLn "Enter a first string as an extraction of the second string!"
   firstString <- getLine
   putStrLn "Enter the second string!"
   secondString <- getLine
   print $ solution firstString secondString 
