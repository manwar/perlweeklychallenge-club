#!/usr/bin/env runghc

-- run as <script> <space-separated line numbers followed by the path to a file>

import System.Environment (getArgs,)
       
main = do
  args <- getArgs
  let (l1:l2:file:_) = args
  txt <- readFile file
  mapM_ putStrLn $ drop ((read l1::Int)-1) $ take (read l2::Int) $ lines txt

