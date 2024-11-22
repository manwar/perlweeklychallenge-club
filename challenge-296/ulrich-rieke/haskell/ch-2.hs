module Challenge296_2 
   where
import Data.List ( init , sort , group )

solution :: [Int] -> Bool
solution list 
   |l < 4 = False
   |l == 4 = all ( == ( head list )) list 
   |otherwise = (mod ( sum list ) 4 == 0) && (sum rest == ( 4 - length maxset ) * max )
    where
     l = length list
     sorted = sort list
     grouped = group sorted
     maxset = last grouped
     max = head maxset
     rest = map sum $ init grouped

main :: IO ( ) 
main = do
   putStrLn "Enter some positive integers separated by blanks!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline
