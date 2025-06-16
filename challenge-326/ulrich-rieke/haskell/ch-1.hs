module Challenge326
   where
import Data.Time.Calendar 
import Data.List.Split ( splitOn ) 

solution :: String -> Integer
solution input = 
   let [ part1 , part2 , part3 ] = splitOn "-" input
       year                      = (read part1 :: Integer ) 
       month                     = read part2
       day                       = read part3
       start                     = fromGregorian year 1 1 
   in (diffDays ( fromGregorian year month day ) start) + 1

main :: IO ( ) 
main = do
   putStrLn "Enter a date in the form YYYY-MM-DD !" 
   dateline <- getLine
   print $ solution dateline
       
