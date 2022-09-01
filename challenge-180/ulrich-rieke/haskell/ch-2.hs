{-# LANGUAGE ScopedTypeVariables #-}
module Challenge180_2
  where
import Data.List.Split ( splitOn )

main :: IO ( )
main = do
  putStrLn "Enter a number of integers, separated by a blank!"
  numbers <- getLine
  putStrLn "Enter a single integer!"
  num <- getLine
  let ( nums :: [Int] ) = map read $ splitOn " " numbers
      (number :: Int )    = read num
  print $ filter ( > number ) nums
