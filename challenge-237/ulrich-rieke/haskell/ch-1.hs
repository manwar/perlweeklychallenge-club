module Challenge237
   where
import Data.Time.Calendar
import Data.Maybe ( fromJust )
import Data.List ( (!!) )   

numToDayOfWeek :: [(Int , DayOfWeek)]
numToDayOfWeek = zip [1..7] [Monday, Tuesday , Wednesday, Thursday, Friday, Saturday , 
	       Sunday]

findFirstSuitableWeekday :: Day -> DayOfWeek -> Day
findFirstSuitableWeekday d wd 
   |dayOfWeek d == wd = d
   |otherwise = until ( (== wd ) . dayOfWeek ) ( addDays 1  ) d 

findFinalDay :: Day -> Int -> Day
findFinalDay d pos 
   |pos == 1 = d
   |otherwise = addDays ( toInteger ((pos - 1) * 7 )) d

getDay :: Day -> Int
getDay day = d
 where
  (_ , _ , d ) = toGregorian day

getMonth :: Day -> Int
getMonth day = mo
 where
  (_ , mo , _) = toGregorian day

main :: IO ( )
main = do
   putStrLn "Enter a year( positive integer ) , a month( integer from 1 to 12 ) ," 
   putStrLn "a weekday position( integer from 1 to 5 ) and a weekday ( from 1 to 7 )!"
   datepartsStr <- getLine 
   let dateParts = map read $ words datepartsStr
       startDay = fromGregorian ( toInteger $ head dateParts )  (dateParts !! 1 )  1  
       wantedWeekday = fromJust $ lookup ( dateParts !! 3 ) numToDayOfWeek
       firstWeekday = findFirstSuitableWeekday startDay wantedWeekday
       finalDay = findFinalDay firstWeekday ( dateParts !! 2 )
   if (getMonth finalDay) /= dateParts !! 1 then print 0 else print ( getDay finalDay ) 
