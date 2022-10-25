module Challenge188
  where
import Data.List.Split ( splitOn )
import Data.List ( (!!) )

solution :: [Int] ->  Int -> Int
solution aList divisor = length $ filter (\p -> mod ( fst p + snd p ) divisor == 0)
[(aList !! i, aList !! j) | i <- [0 .. length aList - 2] , j <- [i + 1 ..
length aList - 1]]


main :: IO ( )
main = do
  putStrLn "Please enter a number of positive integers , separated by a blank!"
  allNumbers <- getLine
  putStrLn "Enter an integer as divisor!"
  divisor <- getLine
  print $ solution ( map read $ splitOn " " allNumbers ) ( read divisor )
