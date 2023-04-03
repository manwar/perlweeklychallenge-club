module Challenge210_2
  where
import Data.List.Split ( divvy )
import Data.List ( (!!) , findIndices )

isValid :: [Int] -> Bool
isValid list = not $ any (\li -> (head li > 0) && (last li < 0)) $  divvy 2 1 list

eliminate :: [Int] -> [Int]
eliminate list = take i list ++ eli_elements ++ drop ( i + 2 ) list
where
  i :: Int --here positive numbers meet negative ones
  i = head $ findIndices (\n -> (list !! n > 0) && (list !! ( n + 1 ) < 0))
  [0..length list - 2]
  diff :: Int -- we replace numbers depending on their absolute val.
  diff = abs ( list !! i ) - abs ( list !! ( i + 1 ) )
  eli_elements :: [Int]
  eli_elements
  |diff > 0 = [list !! i ]
  |diff < 0 = [list !! (i + 1 ) ]
  |diff == 0 = []

solution :: [Int] -> [Int]
solution list = until isValid eliminate list

main :: IO ( )
main = do
  putStrLn "Enter some positive and negative integers, separated by blanks!"
  numbers <- getLine
  let nums = map read $ words numbers
  print $ solution nums
