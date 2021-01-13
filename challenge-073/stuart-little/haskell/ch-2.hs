#!/usr/bin/env runghc

-- run as <script> <space-separated numbers>

import System.Environment (getArgs,)
import Data.List (inits,)

condmin xs
  |last xs == minimum xs =0
  |otherwise =minimum xs
  
condmins xs = map condmin $ drop 1 $ inits xs
       
main = do  
  args <- getArgs  
  putStrLn $ unwords $ map show $ condmins $ map (read::String->Int) args
