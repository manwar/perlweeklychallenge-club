module Challenge228_2
   where
import Data.List ( findIndex ) 

solution :: [Int] -> Int
solution list = fst $ until ( null . snd ) step (0 , list)
 where
  step :: (Int , [Int]) -> (Int , [Int] )
  step ( aNum , aList ) = (aNum + 1 , if (findIndex ( == mini ) aList ) == Just 0 
   then tail aList else tail aList ++ [head aList] ) 
   where
    mini :: Int
    mini = minimum aList

main :: IO ( ) 
main = do
   putStrLn "Enter some unique integers, separated by blanks!" 
   numberstrings <- getLine 
   let numbers = map read $ words numberstrings
   print $ solution numbers

