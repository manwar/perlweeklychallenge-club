module Challenge227
   where
import Data.Time.Calendar 

solution :: Integer -> Int
solution year = length $ filter ( (== Friday ) . dayOfWeek ) allDays
 where
  allDays :: [Day]
  allDays = map (\i -> fromGregorian year i 13 ) [1..12]


main :: IO ( ) 
main = do
   putStrLn "Enter a year, preferably between 1853 and 9999" 
   year <- getLine
   let theYear = (read year :: Integer)
       fridays = solution theYear
   putStrLn ("There are " ++ show fridays ++ " Friday 13th in year " ++ year) 
