module Challenge245
   where
import Data.List ( sortOn ) ;

solution :: [String] -> [Int] -> [String]
solution languages popularities = map fst $ sortOn snd $ zip languages popularities

main :: IO ( ) 
main = do
   putStrLn "Enter some computer languages, separated by blanks!" 
   languages <- getLine
   putStrLn "Enter some corresponding popularities, separated by blanks!" 
   popularities <- getLine
   let pops = map read $ words popularities
   print $ solution ( words languages ) pops
