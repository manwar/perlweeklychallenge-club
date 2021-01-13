#!/usr/bin/env runghc

-- run as <script> <space-separated coordinates, i.e. p1x p1y p2x p2y ... >

import System.Environment   
import Data.List
import Data.List.Split (chunksOf)
import Data.Matrix (detLU,fromLists)

areCollin p q r = detLU mat == 0
  where mat = fromLists [(1:p),(1:q),(1:r)]

pairs ps = [((ps !! i),(ps !! j)) | i <- [0..length ps-1], j <- [0..length ps -1], i<j]

maxCollin ps = maximum $ map length $ map (\(p,q) -> filter (\x -> areCollin p q x) ps) $ pairs ps

main = do  
  args <- getArgs
  putStrLn $ show $ maxCollin $ chunksOf 2 $ map (read::String->Float) args
