{-# LANGUAGE ScopedTypeVariables #-}
module Challenge178_2
  where
import Data.Time.Calendar
import Data.List.Split ( splitOn )

-- find the next workday if the day we jump to is a holiday
findNextWorkday :: Day -> Day
findNextWorkday d
  |dayOfWeek d == Saturday = addDays 2 d
  |dayOfWeek d == Friday = addDays 3 d
  |otherwise = addDays 1 d

--
clipToWorkday :: Int -> Day -> ( Int , Day )
clipToWorkday hour d
  |hour >= 9 && hour <= 18 = if dayOfWeek d == Saturday || dayOfWeek
    d == Sunday then ( 9 + hour - 18 , findNextWorkday d )
    else ( hour , d )
  |hour > 18 = ( hour - 12 , findNextWorkday d )
  |otherwise = ( hour , d ) --dummy arm to satisfy the compiler

parseTheTime :: Double -> (Int , Int )
parseTheTime t = ( theHours , theTime - 60 * theHours )
where
  theHours :: Int
  theHours = div theTime 60
  theTime :: Int
  theTime = floor ( t * 60.0 )

main :: IO ( )
main = do
  putStrLn "Enter a start date in the form year-month-day!"
  startDate <- getLine
  putStrLn "Enter the current time in the form hour:minute!"
  theTime <- getLine
  putStrLn "Enter the duration in hours as a number with decimal point!"
  duration <- getLine
  let ([year , month , day] :: [Int]) = map read $ splitOn "-" startDate
      timeElements = map read $ splitOn ":" theTime
      hour = head timeElements
      minute = last timeElements
      (dur :: Double) = read duration
      daysLater = div ( floor dur ) 9
      (hoursLater :: Double) = dur - ( fromIntegral (daysLater * 9 ))
      startDay = fromGregorian ( toInteger year ) month day
      targetDay = addDays ( toInteger daysLater ) startDay
      targetHour = fromIntegral hour + hoursLater
      (businessHour , businessMinute ) = parseTheTime targetHour
      businessDay = snd $ clipToWorkday businessHour targetDay
  putStr $ showGregorian businessDay
  putStr ( ", " ++ show businessHour ++ ":" )
  if businessMinute < 10 then putStrLn ( "0" ++ show businessMinute )
  else putStrLn $ show businessMinute
