module Challenge325_2
   where
import Data.List( (!!) , init ) 

solution :: [Int] -> [Int]
solution list = 
   let pairs = zip [0 , 1 .. ] list
       selected = (map (\p -> ( fst p , filter (\n -> n <= list !! ( fst p ) ) $ drop 
	 ( fst p + 1 ) list )) $ init pairs) ++ [( fst $ last pairs , [] ) ]
   in map (\p -> if null $ snd p then list !! ( fst p ) else list !! ( fst p ) - 
	 ( head $ snd p ) ) selected

main :: IO ( ) 
main = do
   putStrLn "Enter some prices separated by blanks!" 
   priceline <- getLine
   print $ solution $ map read $ words priceline
