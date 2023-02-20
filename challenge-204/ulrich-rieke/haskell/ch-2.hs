module Challenge204_2
  where
import Data.List.Split ( chunksOf , splitOn)

findSolution :: [[Int]] -> Int -> Int -> [[Int]]
findSolution array rows cols
  |mod ( length allNumbers ) ( rows * cols ) == 0 = chunksOf cols allNumbers
  |otherwise = [[]]
  where
    allNumbers :: [Int]
    allNumbers = concat array

askForCorrectInput :: IO [[Int]]
askForCorrectInput = do
  putStrLn "Please enter an array as a series of sublists separated by | !"
  putStrLn "Sublists should have identical number of elements!"
  putStrLn "Separate numbers in sublists by blanks!"
  numbers <- getLine
  let numberlists = map words $ splitOn "|" numbers
  if  all (\li -> length li == ( length $ head numberlists )) numberlists
  then return $ map ( map read ) numberlists
  else do
      askForCorrectInput

main :: IO ( )
main = do
  numberlists <- askForCorrectInput
  putStrLn "Please enter rows and columns, separated by a blank!"
  nums <- getLine
  let [r , c] = map read $ words nums
      solution = findSolution numberlists r c
  if solution == [[]] then print 0 else print solution
