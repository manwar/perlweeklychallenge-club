module Challenge306_2
   where
import Data.List( sort , (!!) )

convert :: [Int] -> [Int]
convert list =
   let sorted = sort list
       len = length sorted
   in if sorted !! ( len - 1 ) == sorted !! ( len - 2 ) then take ( len - 2)
    sorted else sort  ( take ( len - 2 ) sorted ++ [last sorted  -
     ( sorted !! ( len - 2 ))] ) 

solution :: [Int] -> Int
solution list = if length result == 1 then head result else 0
 where
  result :: [Int]
  result = until (\l -> length l == 1 || length l == 0 ) convert list

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by whitespace!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline

    
