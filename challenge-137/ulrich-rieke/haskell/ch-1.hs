module Challenge137
  where
import Data.Time.Calendar ( fromGregorian )
import Data.Time.Calendar.WeekDate ( toWeekDate )
import Data.List.Split ( chunksOf )
import Data.List ( intercalate )

findSecond :: (Integer , Int , Int) -> Int
findSecond ( _ , b , _ ) = b

findLastWeek :: Integer -> Int
findLastWeek year = findSecond $ toWeekDate $ fromGregorian year 12 31

toStrings :: [Integer] -> [String]
toStrings years = map (\li -> intercalate ", "  li ) $ map (\l ->
map show l ) $ chunksOf 5 years

solution :: [Integer]
solution = filter (\i -> (findLastWeek i) == 53 ) [1900..2100]

main :: IO ( )
main = do
  longyears <- return solution
  let stringlist = toStrings longyears
  mapM_ putStrLn stringlist
