module Challenge138
  where
import Data.Time.Calendar
import Data.Time.Calendar.WeekDate ( toWeekDate )

findThird :: ( Integer , Int , Int ) -> Int
findThird ( _ , _ , c ) = c

solution :: Integer -> Int
solution year
  |isLeapYear year = length $ filter myCondition
    $ map (\i -> addDays i silvester ) [1 .. 366]
  |otherwise = length $ filter myCondition $ map (\i -> addDays i silvester )
    [1 .. 365]
  where
      silvester :: Day
      silvester = fromGregorian (year - 1 ) 12 31
      myCondition :: Day -> Bool
      myCondition aday = (findThird $ toWeekDate aday) `elem` [1 .. 5]
