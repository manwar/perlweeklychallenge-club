{-# LANGUAGE FlexibleContexts #-}
module Challenge160_2
  where
import Data.List.Split ( splitOn )

askForInput :: IO [Int]
askForInput = do
  putStrLn "Enter at least 3 integers, separated by a blank!" ;
  line <- getLine ;
  let numbers = map read $ splitOn " " line
  if length numbers >= 3 then return numbers
  else do
      askForInput

splitList :: [Int] -> [(Int, ([Int] , [Int] ))]
splitList numbers = zip [1 .. l - 2] transformedList
  where
      l :: Int
      l = length numbers
      transformedList :: [([Int] , [Int] )]
      transformedList = map (\i -> (take i numbers , drop ( i + 1 ) numbers ))
      [1 .. l - 2]

solution :: [Int] -> Maybe Int
solution numbers = if null foundList then Nothing else Just (fst $ head foundList)
  where
      foundList :: [(Int, ([Int] , [Int]))]
      foundList = filter (\p -> (sum $ fst $ snd p ) == ( sum $ snd $ snd p )) $
      splitList numbers

main :: IO ( )
main = do
  numbers <- askForInput
  let sol = solution numbers
  case sol of
      Nothing -> putStrLn "-1 as no Equilibrium Index found."
      Just n -> putStrLn $ show n
