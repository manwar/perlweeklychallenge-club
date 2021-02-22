#!/usr/bin/env runghc

-- run <script> <quoted string>

import System.Environment (getArgs,)

main = do
  str <- getArgs >>= return.head
  putStrLn $ unwords $ reverse $ words str
