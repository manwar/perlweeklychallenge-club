module Challenge259
   where
import Data.Time.Calendar
import Data.List.Split ( splitOn )
import Data.List ( (!!) )   

solution :: Day -> Int -> [Day] -> Day
solution start offset holidays = snd $ until ( (== 0 ) . fst ) step
 (offset , start )
 where
  step :: (Int, Day) -> (Int , Day)
  step (currentnum , currentdate ) = if (dayOfWeek nextDay == Saturday) 
   || (dayOfWeek nextDay == Sunday ) || elem nextDay holidays then 
   (currentnum , nextDay) else ( currentnum - 1 , nextDay )
   where
    nextDay :: Day
    nextDay = addDays 1 currentdate 

getHolidays :: IO [String]
getHolidays = do
   dayOff <- getLine
   if ( not $ null dayOff ) then do
    restOfDays <- getHolidays
    return (dayOff:restOfDays)
   else do
    return []

stringToDay :: String -> Day    
stringToDay str = fromGregorian (toInteger $ head dateparts ) ( dateparts !!
 1 ) ( dateparts !! 2 )
 where 
  dateparts = map read $ splitOn "-" str 

main :: IO ( ) 
main = do
   putStrLn "Enter a start date in the form <year>-<month>-<day>!"
   startDate <- getLine
   putStrLn "Enter a day offset!"
   offset <- getLine
   putStrLn "Enter some bank holidays, each date in the format above!"
   putStrLn "Enter <return> to end entry!"
   holidays <- getHolidays
   print $ showGregorian $ solution (stringToDay startDate ) (read offset)
    (map stringToDay holidays )	 
