module Challenge269_2
   where
import Data.List ( (!!) ) 

solution :: [Int] -> [Int]
solution list = part1 ++ part2 
 where
  (part1 , part2) = foldl myCombiner ([list !! 0] , [list !! 1 ] )
   ( drop 2 list )
   where 
    myCombiner :: ([Int] , [Int] ) -> Int -> ([Int] , [Int])
    myCombiner ( arr1 , arr2 ) number = if last arr1 > last arr2 then
     (arr1 ++ [number] , arr2 ) else (arr1 , arr2 ++ [number])

main :: IO ( ) 
main = do
   putStrLn "Enter some distinct integers separated by blanks!"
   numberstrings <- getLine
   print $ solution $ map read $ words numberstrings
