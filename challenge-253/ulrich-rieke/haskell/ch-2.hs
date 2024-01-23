module Challenge253_2
   where
import Data.List ( sortBy )

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d (x:xs)
   |d == x = 1 + count d xs
   |otherwise = count d xs

solution :: [[Int]] -> [Int]
solution list = map fst $ sortBy mySorter $ zip [0..] list
 where
  mySorter :: (Int  ,[Int]) -> (Int, [Int]) -> Ordering
  mySorter firstList secondList = if firstOnes /= secondOnes then 
   compare firstOnes secondOnes else compare ( fst firstList ) 
   ( fst secondList )
   where
    firstOnes = count 1 ( snd firstList )
    secondOnes = count 1 ( snd secondList )

getMultipleLines :: Int -> IO [String]
getMultipleLines n
   |n <= 0 = return []
   |otherwise = do
      x <- getLine
      xs <- getMultipleLines ( n - 1 )
      let ret = (x:xs)
      return ret     

main :: IO ( )
main = do
   putStrLn "Enter a matrix of 1 and 0 only, beginning with 1's in line!"
   putStrLn "How many lines do you want to enter ?"
   myLines <- getLine
   allNumbers <- getMultipleLines ( read myLines )
   let matrix = map ( map read . words ) allNumbers
   print $ solution matrix
