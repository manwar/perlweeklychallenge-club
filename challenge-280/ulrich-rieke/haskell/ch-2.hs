module Challenge280_2
   where
import Data.List ( findIndices )
import Data.List.Split ( chunksOf )

findForbiddenIndices :: String -> [Int]
findForbiddenIndices s = concat $ map (\subli -> if length subli == 2 then
 [head  subli..last subli] else [] ) $ chunksOf 2 indices
 where
  indices = findIndices ( == '|' ) s 

solution :: String -> Int
solution s = if (length $ findIndices ( == '|' ) s ) <= 1 then length $ 
 findIndices ( == '*' ) s else length $ filter (\p -> notElem ( fst p )
  forbidden &&  ( snd p == '*' ) ) $ zip [0 , 1 .. ] s 
  where
   forbidden = findForbiddenIndices s 

main :: IO ( )
main = do
   putStrLn "Enter a string with some vertical bars!"
   line <- getLine
   print $ solution line


 
