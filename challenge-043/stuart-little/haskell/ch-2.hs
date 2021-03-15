#!/usr/bin/env runghc

-- run <script> <base>

import Data.Digits (digits,)
import System.Environment (getArgs,)

selfDesc :: Int -> Maybe Int
selfDesc b
  |elem b [1,2,3,6] =Nothing
  |otherwise = Just ((b - 4)*b^(b-1) + 2*b^(b-2) + b^(b-3) + b^3)

main = do
  b <- getArgs >>= return.(read::String->Int).head
  putStrLn $ maybe "No self-descriptive numbers in this base." (\nrb -> let diglist = digits b nrb in "Number in base " ++ (show b) ++ ": " ++ (unwords $ map show diglist) ++ "\nNumber in base 10: " ++ (show nrb)) $ selfDesc b
