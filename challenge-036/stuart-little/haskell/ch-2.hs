#!/usr/bin/env runghc

-- run <script> <nr of boxes; defaults to arbitrary>

import Data.List (subsequences,sortOn,)
import Data.List.Utils (join,)
import Data.Maybe (isNothing,fromJust,)
import Safe (headMay,lastDef,)
import System.Environment (getArgs,)

data Knapsack = KS { name :: String  
                   , weight :: Float
                   , amount :: Float
                   } deriving (Show)   

optKS :: Maybe Int -> Float -> [Knapsack] -> [Knapsack]
optKS nr underw sacks = lastDef [] $ sortOn (sum.(map amount)) $ filter (nrSacks nr) $ filter ( (underw >).sum.(map weight) ) $ subsequences sacks where
  nrSacks :: Maybe Int -> [Knapsack] -> Bool
  nrSacks nr = if (isNothing nr)
               then (const True)
               else ((fromJust nr)==).length

main = do
  nrbx <- getArgs >>= return.headMay.(map (read::String->Int))
  let res = optKS nrbx 15 sacks where
        sacks = [ KS {name = "R", weight=1.0, amount=1.0},
                  KS {name = "B", weight=1, amount=2},
                  KS {name = "G", weight=2, amount=2},
                  KS {name = "Y", weight=12, amount=4},
                  KS {name = "P", weight=4, amount=10.0}
                ]
  putStrLn $ "Result: " ++ (join " + " $ map name res)
  putStrLn $ "Total weight: " ++ (show $ sum $ map weight res)
  putStrLn $ "Total value: " ++ (show $ sum $ map amount res)
