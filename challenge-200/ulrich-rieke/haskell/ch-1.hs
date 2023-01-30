module Challenge200
  where
import Data.List.Split ( divvy )
import qualified Data.Set as S

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] ,
x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]
 
solution :: [Int] -> [[Int]] 
solution list
  |l < 3 = []
  |otherwise = filter myCondition $ concat $ map (\i -> combinations i list )
    [3..l]
    where
    l :: Int
    l = length list
    myCondition :: [Int] -> Bool
    myCondition li = length ( S.toList $ S.fromList (map (\subl ->
      last subl - head subl ) $ divvy 2 1 li )) == 1

main :: IO ( )
main = do
  putStrLn "Please enter some integers, separated by a blank!"
  numberline <- getLine
  let numbers = map read $ words numberline
  print $ solution numbers
