module Challenge208_2
  where
import Data.List ( sort )
import Data.List.Split ( divvy )

reorder :: [Int] -> [(Int , Int)]
reorder list = zip list divvied
where
  divvied :: [Int]
  divvied = map (\subl -> last subl - head subl ) $ divvy 2 1 list

solution :: [Int] -> [Int]
solution list = (map fst $ filter ( (== 0) . snd ) $ init reordered) ++ ( map (\p -> fst p
+ 1 ) $ filter ( (> 1 ) . snd ) $ init reordered ) ++ ( checkLast $ last reordered )
where
  reordered :: [(Int , Int)]
  reordered = reorder list
  checkLast :: (Int , Int ) -> [Int]
  checkLast ( p , q )
  |q == 0 = [p , p + 1]
  |q == 1 = []
  |q > 1 = [p + 1]

main :: IO ( )
main = do
  putStrLn "Please enter integers, separated by blanks, with at most one gap and duplicate!"
  numberstrings <- getLine
  let numbers = map read $ words numberstrings
      transformed = solution numbers
  if not $ null transformed
  then print $ sort transformed
  else print "-1"
