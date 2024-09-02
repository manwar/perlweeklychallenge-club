module Challenge284
   where
import Data.List ( findIndices )

solution :: [Int] -> Int
solution list 
   |null selected = -1
   |l == 1 = head selected
   |otherwise = maximum selected
    where
     selected = map fst $ filter (\p -> fst p == (length $ snd p ) ) $
      map (\i -> (i , findIndices (== i ) list ) ) list
     l = length selected

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by blanks!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline
