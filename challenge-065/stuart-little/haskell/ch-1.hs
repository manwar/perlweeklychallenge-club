#!/usr/bin/env runghc

-- run <script> <digit_number digit_sum>

import System.Environment (getArgs,)

digSum :: Int -> Int
digSum = sum . (map (read::String->Int)) . (map (\x -> [x])) . show

main = do
  args <- getArgs
  let (dignr:digsum:_) = map (read::String->Int) args
  putStrLn $ unwords $ map show $ filter ((digsum==).digSum) [10 ^ (dignr-1) .. 10 ^ dignr -1]
