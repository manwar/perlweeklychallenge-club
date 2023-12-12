module Challenge247_2
   where
import qualified Data.Set as S
import Data.List.Split ( divvy )
import Data.List ( (!!) , sortBy ) 

mySorter :: (String , Int) -> (String , Int ) -> Ordering
mySorter ( s1 , i1 ) ( s2 , i2 )
   |i1 /= i2 = if compare i1 i2 == LT then GT else LT
   |otherwise = compare s1 s2 

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d (x:xs)
   |d == x = 1 + count d xs
   |otherwise = count d xs
   
solution :: String -> String
solution s = fst  ((sortBy mySorter countlist) !! 0 )
 where
  pairs = divvy 2 1 s
  uniques = S.toList $ S.fromList $ divvy 2 1 s
  countlist = map (\substr -> ( substr , count substr pairs ) ) uniques

main :: IO ( ) 
main = do
   putStrLn "Enter a string consisting of lowercase letters only!" 
   line <- getLine
   print $ solution line
