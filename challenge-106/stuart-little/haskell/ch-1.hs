#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import Data.List (sort)
import Safe (maximumDef)
import System.Environment (getArgs)

maxGap :: [Int] -> Int
maxGap xs = maximumDef 0 $ map (\x -> snd x - fst x) $ zip sorted $ tail sorted where
  sorted = sort xs

main = do
  nrs <- getArgs >>= return . map (read::String->Int)
  print $ maxGap nrs
