module Challenge175
  where
import Data.Time.Calendar

findLastSunday :: Integer -> Int -> Day
findLastSunday year month = myFunc $ fromGregorian year month
(gregorianMonthLength year month )
  where
  myFunc :: Day -> Day
  myFunc d = until ( (== Sunday ) . dayOfWeek ) change d
    where
    change = addDays (- 1 )

solution :: Integer -> [String]
solution year = map (\m -> showGregorian $ findLastSunday year m ) [1 .. 12]
