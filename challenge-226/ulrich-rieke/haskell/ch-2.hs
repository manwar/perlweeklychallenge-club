module Challenge226_2
   where

mySubtr :: Int -> Int -> Int
mySubtr a b = if a - b < 0 then 0 else a - b  
   
solution :: [Int] -> Int
solution list = fst $ until ( all (\i -> i == 0 ) . snd ) step ( 0 , list ) 
 where
  step :: ( Int , [Int] ) -> ( Int , [Int] )
  step ( num , aList ) = ( num + 1 , map (\n -> mySubtr n mini ) aList ) 
   where
    mini :: Int
    mini = minimum $ filter ( > 0 ) aList

main :: IO ( )
main = do
   putStrLn "Enter some positive integers, separated by blanks!" 
   numberstrings <- getLine
   print $ solution $ map read $ words numberstrings
