#!/usr/bin/env runghc

-- run <script> <year>

import System.Environment (getArgs)

animal :: [a] -> Int -> Int -> a
animal animals year base = (!!) animals $ mod (year - base) $ length animals

elt :: [a] -> Int -> Int -> a
elt elts year base = (!!) elts $ flip div 2 $ mod (year - base) $ 2*(length elts)

animals :: [String]
animals = ["Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster", "Dog", "Pig"]

elts :: [String]
elts=["Wood", "Fire", "Earth", "Metal", "Water"];

main = do
  yr <- getArgs >>= return . (read::String->Int) . head
  putStrLn $ (elt elts yr 1924) ++ " " ++ (animal animals yr 1924)
