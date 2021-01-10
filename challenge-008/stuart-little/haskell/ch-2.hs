#!/usr/bin/env runghc

-- run <script> <space-separated quoted strings>

import System.Environment (getArgs,)

center :: [String] -> [String]
center strs = map (\s -> (replicate (div (lng - length s) 2) ' ') ++ s) strs where
  lng = maximum $ map length strs

main = do
  args <- getArgs
  mapM_ putStrLn $ center args
