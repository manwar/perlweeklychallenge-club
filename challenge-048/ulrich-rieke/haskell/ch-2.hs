module Challenge048_2
  where
import Data.List( unfoldr )
import Data.Time.Calendar

allDays :: [Day]
allDays = unfoldr(\d -> if d == (fromGregorian 3000  1  1 )  then Nothing
      else Just ( d , addDays 1 d ) ) ( fromGregorian 2000 1 1 )

solution :: [String]
solution = filter (\s -> s == reverse s ) $ map ( reorder . showGregorian )
  allDays

reorder :: String -> String
reorder date = drop 8 date ++ ( take 2 $ drop 5 date ) ++ ( take 4 date )
