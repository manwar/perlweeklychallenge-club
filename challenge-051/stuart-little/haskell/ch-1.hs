#!/usr/bin/env runghc

-- run <script> <target, space-separated numbers>

import System.Environment (getArgs,)

tripSum t xs = concat $ map (\(xs,h,ys) -> [(a,h,t-a-h) | a <- xs, elem (t-a-h) ys]) $ map (\(xs,(h:ys)) -> (xs, h, ys)) $ map (\idx -> splitAt idx xs) [1..length xs-2]
  
main = do
  args <- getArgs
  let (t:xs) = map (read::String->Int) args
  mapM_ print $ tripSum t xs
