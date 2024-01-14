module Challenge251_2
   where
import Data.List ( transpose , intersect )

solution :: [[Int]] -> Int   
solution matrix = if null intersection then -1 else head intersection
 where
  minima :: [Int]
  minima = map minimum matrix
  maxima :: [Int]
  maxima = map maximum $ transpose matrix
  intersection :: [Int]
  intersection = intersect minima maxima

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
   putStrLn "Enter m lines of n integers separated by blanks!"
   putStrLn "How many lines do you want to enter?" ;
   number <- getLine
   numberstrings <- getMultipleLines $ read number
   let matrix = map (\s -> map read $ words s ) numberstrings
   print $ solution matrix

