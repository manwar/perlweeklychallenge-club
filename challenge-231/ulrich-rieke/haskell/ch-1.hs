module Challenge231
   where

convert :: [Int] -> [Int]
convert list = filter (\i -> i /= maxi && i /= mini ) list
 where
  maxi = maximum list
  mini = minimum list

main :: IO ( )
main = do
   putStrLn "Enter some different integers, separated by blanks!" ;
   numberstrings <- getLine 
   let numbers = map read $ words numberstrings
       converted = convert numbers
   if null converted then print "-1" else print converted    
