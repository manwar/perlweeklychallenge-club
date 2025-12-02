module Challenge350_2
   where
import qualified Data.Set as S
import Data.List ( groupBy ) 

arePaired :: Int -> Int -> Bool
arePaired firstnum secondnum = 
   let firststr = show firstnum
       secondstr = show secondnum
       firstset = S.fromList firststr
       secondset = S.fromList secondstr
   in and [length firststr == length secondstr, firstset == secondset , 
    S.size firstset == length secondstr]
     

solution :: Int -> Int -> Int -> Int  
solution from to count =  length $ filter ( (>= count ) . length ) $ groupBy (\ a b ->
   fst a == fst b ) $ filter (\p -> arePaired ( fst p ) ( snd p )) $ [(i , mult * i)
    | i <- [from..to] , mult <- [2..9]]
 

main :: IO ( ) 
main = do
   print $ solution 1 1000 1
   print $ solution 1500 2500 1
   print $ solution 1000000 1500000 5
   print $ solution 13427000 14100000 2
   print $ solution 1030 1130 1
