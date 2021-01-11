#!/usr/bin/env runghc

-- run <script> <number>

import System.Environment (getArgs,)
import Math.TreeFun.Tree (boolToInt,)

main = do
  (nr:_) <- getArgs
  putStrLn $ show $ boolToInt (nr == reverse nr)
