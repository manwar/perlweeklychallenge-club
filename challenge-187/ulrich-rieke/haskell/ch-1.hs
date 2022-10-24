module Challenge187
  where
import Data.Time.Calendar
import Data.List.Split( splitOn )
import qualified Data.Set as S

readDate :: String -> Day
readDate s = fromGregorian 2022 ( last list ) ( head list )
where
  list :: [Int]
  list = map read $ splitOn "-" s

createDateRange :: Day -> Day -> [Day]
createDateRange start end = until ( (== end ) . last ) step [start]
where
  step :: [Day] -> [Day]
  step fromList = fromList ++ [addDays 1 ( last fromList)]

main :: IO ( )
main = do
  putStrLn "Enter the start date of Foo as <month>-<day>"
  fooStart <- getLine
  putStrLn "Enter the end date of Foo as <month>-<day>"
  fooEnd <- getLine
  putStrLn "Enter the start date of Bar as <month>-<day>"
  barStart <- getLine
  putStrLn "Enter the end date of Bar as <month>-<day>"
  barEnd <- getLine
  let firstDateSet = S.fromList $ createDateRange (readDate fooStart)
        ( readDate fooEnd )
      secondDateSet = S.fromList $ createDateRange ( readDate barStart )
        ( readDate barEnd )
  putStr $ show $ length $ S.toList $ firstDateSet `S.intersection`
    secondDateSet
  putStrLn " days"
