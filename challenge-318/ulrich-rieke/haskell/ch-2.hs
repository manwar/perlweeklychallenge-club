module Challenge318_2
   where
import Data.List ( groupBy )
import Data.List.Split ( divvy )
import Data.Maybe ( fromJust ) 

solution :: [Int] -> [Int] -> Bool
solution firstlist secondlist =
   let
      firstzipped = zip [0 , 1 .. ] firstlist
      secondzipped = zip secondlist [0 , 1 .. ]
      newPairs = map (\p -> ( fst p , fst p + ( fromJust $ lookup ( snd p )
       secondzipped ))) firstzipped
      grouped = groupBy(\ p1 p2 -> snd p1 == snd p2 ) newPairs
      moreThanOne = filter ( (> 1 ) . length ) grouped 
   in ( length $ filter ( isAscending . map fst ) moreThanOne ) == 1

isAscending :: [Int] -> Bool
isAscending list = all (\subli -> (last subli - head subli) == 1 ) $ 
 divvy 2 1 list

main :: IO ( ) 
main = do
   putStrLn "Enter a first list of integers!"
   line <- getLine
   putStrLn "Enter a second list of integers with the same numbers!"
   secondline <- getLine
   if length line == 1 && length secondline == 1 then print "True" else
    print $ solution ( map read $ words line ) ( map read $ words secondline)
