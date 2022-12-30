module Challenge197_2
  where
import Data.List (group , sort , sortOn , (!! ) , permutations )
import qualified Data.Set as S

myCondition :: [Int] -> Bool
myCondition numbers
  |l == 3 = numbers !! 0 < numbers !! 1 && numbers !! 1 > numbers !! 2
  |l > 3 = all (\p -> fst p < snd p ) firstPairs && all (\p -> fst p
    > snd p ) secondPairs
  where
    l :: Int
    l = length numbers
    firstPairs :: [(Int , Int)]
    firstPairs = map (\i -> (numbers !! i , numbers !! ( i + 1 ))) $
    filter even [0..l - 2]
    secondPairs :: [(Int , Int)]
    secondPairs = map (\i -> ( numbers !! i , numbers !! ( i + 1 ))) $
    filter odd [0 .. l - 2]

askForInput :: IO [Int]
askForInput = do
  putStrLn "Enter at least 3 integers, separated by a blank!"
  numbers <- getLine
  let theNumbers = map read $ words numbers
  if length theNumbers >= 3
  then return theNumbers
  else do
      askForInput

main :: IO ( )
main = do
  numbers <- askForInput
  let theLast = last $ sortOn length $ group $ sort numbers
      l      = length numbers
      permus  = S.toList $ S.fromList $ permutations numbers
  if (l > 3) && ( length theLast >= (l - 1))
  then putStrLn "A wiggle order can't be created!"
  else print $ filter myCondition permus
