module Challenge172
  where
import Data.List ( subsequences , (!!))
import Data.List.Split( splitOn )

isPrime :: Int -> Bool
isPrime n
  |n == 2 = True
  |n == 1 = False
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. root]
  where
      root :: Int
      root = floor $ sqrt $ fromIntegral n

askForInput :: IO ( Int , Int )
askForInput = do
  putStrLn "Please enter 2 numbers, the first being greater than the second!"
  numbers <- getLine
  let nums = map read $ splitOn " " numbers
  if (nums !! 0)  > (nums !! 1 )
  then return ( nums !! 0 , nums !! 1 )
  else do
      askForInput

findLists :: Int -> Int -> [[Int]]
findLists m n = filter ( (== m ) .sum ) $ filter ( (== n ) . length ) $ subsequences
$ filter isPrime [2 .. m]

main :: IO ( )
main = do
  numbers <- askForInput
  print $ findLists ( fst numbers ) ( snd numbers )
