#!/usr/bin/env runghc

-- run <script> <numerator> <denominator>

import System.Environment (getArgs,)
import Data.List (partition,)
import Data.List.Split (chunksOf,)
import Data.Maybe (fromMaybe,)
import Control.Monad (liftM,)

divFunny :: Int -> Int -> Maybe Int
divFunny m n
  |n==0 =Nothing
  |m==0 =Just 0
  |otherwise = let
     (l1,l2) = partition (((abs n)==).length) $ chunksOf (abs n) [1..abs m]
     coeff = (signum m) * (signum n)
     in
       Just $ coeff*(length l1) + (div (coeff - 1) 2)*(length l2)
   
main = do
  args <- getArgs
  let (num:den:_) = map (read::String->Int) args
  putStrLn $ fromMaybe "Division by zero" $ liftM show $ divFunny num den
