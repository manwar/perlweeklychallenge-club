module Challenge221_2
  where
import Data.List ( sortOn , subsequences )
import Data.List.Split( divvy )

is_algorithmic :: [Int] -> Bool
is_algorithmic list = allEqual $ map (\li -> last li - head li )
$ divvy 2 1 list
where
  allEqual :: [Int] -> Bool
  allEqual someList = all (\i -> i == head someList) someList

solution :: [Int] -> Int
solution = length . last . sortOn length . filter is_algorithmic
. subsequences

main :: IO ( )
main = do
  putStrLn "Enter some digits separated by blanks!"
  numbers <- getLine
  print $ solution $ map read $ words numbers
