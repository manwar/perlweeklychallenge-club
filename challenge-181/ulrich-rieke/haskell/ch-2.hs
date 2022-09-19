module Challenge181_2
  where
import Data.List.Split ( splitOn , divvy )
import Data.Maybe ( fromJust )
import Data.List ( sortBy , findIndex , (!!) )


parseLine :: String -> ( String , Int )
parseLine line = ( head smallList , read $ drop 1 $ last smallList )
where
  smallList :: [String]
  smallList = splitOn "," line

mySorter :: (String , Int) -> (String , Int) -> Ordering
mySorter firstPair secondPair
  |fst unequalPair < snd unequalPair = LT
  |fst unequalPair == snd unequalPair = EQ
  |fst unequalPair > snd unequalPair = GT
  where
    firstNumbers :: [Int]
    firstNumbers = map read $ splitOn "-" $ fst firstPair
    secondNumbers :: [Int]
    secondNumbers = map read $ splitOn "-" $ fst secondPair
    numberPairs :: [(Int, Int)]
    numberPairs = zip firstNumbers secondNumbers
    diffIndex :: Int
    diffIndex = fromJust $ findIndex (\p -> fst p /= snd p ) numberPairs
    unequalPair :: (Int , Int )
    unequalPair = numberPairs !! diffIndex

main :: IO ( )
main = do
  inputLines <- fmap lines $ readFile "temperature.txt"
  let parsed = map parseLine inputLines
      sorted = sortBy mySorter parsed
      neighbours = divvy 2 1 sorted
      validDates = fmap (\li -> fst $ last li ) $ filter (\li -> ( snd $ last li ) >
    ( snd $ head li ) ) neighbours
  mapM_ putStrLn validDates
