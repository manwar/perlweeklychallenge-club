module Challenge396
   where
import Data.List ( sortOn , find)
import Data.Maybe ( fromJust )   

solution :: [Int] -> [Int] -> [Int]   
solution order friends =
   let pairs = zip [0 , 1 ..] order
       friendpositions = map (\i -> fromJust $ find ( (== i) . snd ) pairs ) friends
   in map snd $ sortOn fst friendpositions    
   
main :: IO ( )
main = do
   putStrLn "Enter some integers from 1 to n in any order!" 
   orderline <- getLine
   putStrLn "Enter a subset of these integers in ascending order!"
   friendline <- getLine
   print $ solution ( map read $ words orderline ) ( map read $ words friendline )
