#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import System.Environment (getArgs,)

player1Max :: [Float] -> Float
player1Max xs
  |null xs =0
  |otherwise =maximum $ map nextIt [xs, reverse xs] where
     nextIt ys = let tl = tail ys in (head ys) + (sum tl - (player1Max tl))

main = do
  args <- getArgs
  let numArgs=map (read::String->Float) args
      p1Gain = player1Max numArgs
  putStrLn $ "Under the best strategy Player 1 gains " ++ (show p1Gain)
  putStrLn $ "and Player 2 gains " ++ (show $ sum numArgs - p1Gain)

