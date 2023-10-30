module Challenge233_2
   where
import Data.List ( sortBy , sort , group ) 
import Data.Function ( on ) 

solution :: [Int] -> [Int]
solution = concat .sortBy mySorter . group . sort
 where
  mySorter :: [Int] -> [Int] -> Ordering
  mySorter l1 l2 
    |length l1 /= length l2 = ( compare `on` length ) l1 l2
    |otherwise = if ( compare `on` head ) l1 l2 == GT then LT else GT

main = do
   putStrLn "Please enter some integers, separated by blanks!"
   numberstrings <- getLine
   let numbers = map read $ words numberstrings
   print $ solution numbers
