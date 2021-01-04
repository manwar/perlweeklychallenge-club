#!/usr/bin/env runghc

-- run as <script> <window-length followed by space-separated numbers>

import System.Environment (getArgs,)
import Data.List (transpose,)
import Data.List.Extra (groupOn,)

winMins win xs = map minimum $ head $ groupOn length $ transpose $ take win $ iterate tail xs
       
main = do  
  args <- getArgs
  let (win:xs) = map (read::String->Int) args
  putStrLn $ unwords $ map show $ winMins win xs

