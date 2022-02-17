module Challenge152
  where
import Data.List.Split( divvy )

valid :: [[Int]] -> Bool
valid input = all(\l -> abs( (length $ head l) - (length $ last l)) == 1 )
$ divvy 2 1 input

solution :: [[Int]] -> Int
solution list = if not $ valid list then error "One more number per row" else
sum $ map minimum list
