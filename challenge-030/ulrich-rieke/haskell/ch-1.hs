module Christmas
  where
import Data.Time.Calendar( fromGregorian )
import Data.Time.Calendar.WeekDate( toWeekDate , showWeekDate )
import qualified Data.Set as S
import Data.List ( sort )

sundayChristmas :: [ String ]
sundayChristmas =
  let christmasses = map (\i -> fromGregorian i 12 25 ) [2019..2100]
      sundays      = filter (\d -> ( findThirdElement $ toWeekDate d ) == 7  ) christmasses
  in map printDate $ map (\d -> findFirstElement $ toWeekDate d ) sundays

findThirdElement :: ( Integer , Int , Int ) -> Int
findThirdElement (year, month, day) = day

findFirstElement :: ( Integer , Int , Int ) -> Integer
findFirstElement ( year , month, day ) = year

printDate :: Integer -> String
printDate year = show year ++ " Dec." ++ " 25" ;
