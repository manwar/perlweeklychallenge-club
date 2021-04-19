#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import Data.List (intercalate,permutations)
import System.Environment (getArgs)

allEqNr :: (Num a,Eq a) => a -> [a] -> Bool
allEqNr nr as
  |length as <= 3 = nr == sum as
  |otherwise = (nr == (sum $ take 3 as)) && (allEqNr nr $ drop 2 as)

allEqSums :: (Num a,Eq a) => [a] -> Bool
allEqSums as
  |length as <= 2 =True
  |otherwise = allEqNr (sum $ take 2 as) (drop 1 as)

pprnt :: (Show a,Num a) => [a] -> String
pprnt as = "\nSolution: " ++ (intercalate ", " idents) ++ "\nSum: "++(show $ sum $ take 2 as) where
  idents = map (\(f,s)-> [f] ++" = "++(show s)) $ zip ['a'..'g'] as
  
main = do
  args <- getArgs >>= return . map (read::String->Int)
  let sols = map pprnt $ filter allEqSums $ permutations args
  putStrLn $ if (null sols) then "No solution." else unwords sols
