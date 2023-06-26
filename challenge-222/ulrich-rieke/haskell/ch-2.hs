module Challenge222_2
  where
import Data.List ( sort , findIndex )
import Data.List.Split ( divvy )
import Data.Maybe ( fromJust )

solution :: [Int] -> Int
solution list
  |l == 1 = head list
  |l == 2 = abs ( head list - last list )
  |otherwise = head $ until ( (== 1 ) . length ) step list
  where
    l :: Int
    l = length list

step :: [Int] -> [Int]
step aList
  |l == 1 = aList
  |l == 2 = [abs( head aList - last aList)]
  |otherwise = take pos aList ++ [mini] ++ drop ( pos + 2 ) sortedList
  where
    differences :: [Int]
    differences = map (\li -> abs( head li - last li) ) $ divvy 2 1 sortedList
    mini        :: Int
    mini        = minimum $ filter ( /= 0 ) differences
    pos        :: Int
    pos        = fromJust $ findIndex ( == mini ) differences
    sortedList  :: [Int]
    sortedList  = sort aList
    l          :: Int
    l          = length aList

main :: IO ( )
main = do
  putStrLn "Enter some integers , separated by blanks!"
  numberstrings <- getLine
  print $ solution $ map read $ words numberstrings
