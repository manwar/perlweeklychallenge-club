module Challenge132
  where
import Data.List.Split( splitOn )
import Data.Time.Calendar
import Data.List ( (!!) )
import System.Time
import Data.Maybe ( fromJust )

months :: [(Month , Int)]
months = [ ( January , 1) , (February , 2) , (March , 3) , (April , 4) , (May , 5 ) ,
      ( June , 6 ) , (July , 7 ) , ( August , 8) , ( September , 9) , (October , 10 ) ,
      (November , 11 ) , ( December , 12 ) ]

main :: IO ( )
main = do
  putStrLn "Enter a date in the form <year/month/day>!"
  myDate <- getLine
  clockTime <- getClockTime
  calendarTime <- toCalendarTime clockTime
  let dateparts = fmap read $ splitOn "/" myDate
      refDate = fromGregorian ( toInteger $ dateparts !! 0 ) (dateparts !! 1 )
    (dateparts !! 2 )
      today  = fromGregorian ( toInteger $ ctYear calendarTime ) (fromJust
    $ lookup (ctMonth calendarTime ) months ) ( ctDay calendarTime )
      daysPassed = diffDays today refDate
      mirrorBefore = addDays ( - daysPassed ) refDate
      mirrorAfter = addDays daysPassed today
  putStrLn ( showGregorian mirrorBefore ++ ", " ++ showGregorian mirrorAfter )
