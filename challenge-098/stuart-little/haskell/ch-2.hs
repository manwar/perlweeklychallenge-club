#!/usr/bin/env runghc

-- run <script> <target> <space-separated array entries>

import System.Environment (getArgs)

main = do
  (tgt:arr) <- getArgs >>= return . map (read::String->Int)
  putStrLn $ show $ length $ filter (< tgt) arr
