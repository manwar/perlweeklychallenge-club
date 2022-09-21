module Challenge183_2
  where
import Data.Time.Calendar

parseDate :: String -> Day
parseDate s = fromGregorian ( myFirst $ extractFieldsOfDate s ) ( mySecond $
extractFieldsOfDate s ) ( myThird $ extractFieldsOfDate s )
where
  myFirst :: ( Integer , Int , Int ) -> Integer
  myFirst ( a , _ , _ )  = a
  mySecond :: ( Integer , Int , Int ) -> Int
  mySecond ( _ , b , _ ) = b
  myThird :: ( Integer , Int , Int ) -> Int
  myThird  ( _ , _ , c ) = c

extractFieldsOfDate :: String -> ( Integer , Int , Int )
extractFieldsOfDate s = ( toInteger $ read $ take 4 s , read $ take 2 $ drop 5 s ,
read $ drop 8 s )

findDayDifference :: String -> String -> Integer
findDayDifference startDate endDate = diffDays end start - toBeSubtracted
where
  start :: Day
  start = parseDate startDate
  end :: Day
  end = parseDate endDate
  (year1 , month1 , day1 ) = extractFieldsOfDate startDate
  (year2 , month2 , day2 ) = extractFieldsOfDate endDate
  toBeSubtracted :: Integer
  toBeSubtracted = if ( year2 - year1) == 0 then 0 else findStartCondition
  startDate + findEndCondition endDate + leapsInBetween
    where
    leapsInBetween :: Integer
    leapsInBetween = toInteger $ length $ filter isLeapYear $ init $
      tail [year1 ..year2]
    findStartCondition :: String -> Integer
    findStartCondition date = if isLeapYear theYear && theMonth == 1 && theDay == 1
      then 1 else 0
      where
      (theYear , theMonth , theDay ) = extractFieldsOfDate date
    findEndCondition :: String -> Integer
    findEndCondition date = if isLeapYear myYear && myMonth == 12 &&
      myDay == 31 then 1 else 0
      where
        (myYear , myMonth , myDay ) = extractFieldsOfDate date

findAnswer :: Integer -> String
findAnswer days =
  let years = div days 365
      theDays = days - years * 365
      yearPart = if years == 0 then "" else if years == 1 then "1 year "
    else ( show years ++ " years " )
      dayPart = if theDays == 0 then "" else if theDays == 1 then "1 day" else
        (show theDays ++ " days" )
  in yearPart ++ dayPart

main :: IO ( )
main = do
  putStrLn "Enter a start date as yyyy-mm-dd!"
  start <- getLine
  putStrLn "Enter an end date as yyyy-mm-dd!"
  end <- getLine
  putStrLn $ findAnswer $ findDayDifference start end
