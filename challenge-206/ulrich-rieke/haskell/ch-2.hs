module Challenge206_2
  where
import Data.List.Split ( chunksOf )
import Data.List ( permutations , (!!) )

isValid :: [Int] -> Bool
isValid list = all (\p -> head p <= last p ) $ chunksOf 2 list

askForValidInput :: IO [Int]
askForValidInput = do
  putStrLn "Please enter an even number of integers, separated by a blank!"
  numline <- getLine
  let numbers = map read $ words numline
  if even $ length numbers then return numbers
  else do
      askForValidInput

findValidPositions :: [Int] -> [[Int]]
findValidPositions list = filter isValid $ permutations list

findValidPermutations :: [Int] -> [[Int]]
findValidPermutations list = map (\li -> map (\i -> list !! i) li ) $
  findValidPositions [0..length list - 1]

findLocalMins :: [Int] -> [Int]
findLocalMins list = map (\li -> min ( head li ) ( last li )) $ chunksOf 2 list

findAllMins :: [Int] -> [[Int]]
findAllMins list = map (\subli -> findLocalMins subli ) $ findValidPermutations list

solution :: [Int] -> Int
solution list = maximum $ map sum $ findAllMins list

main :: IO ( )
main = do
  numbers <- askForValidInput
  print $ solution numbers
