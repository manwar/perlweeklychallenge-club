#!/usr/bin/env runghc

-- run as <script> <number>

import System.Environment   

nrbits 0 = 0
nrbits x = (mod x 2) + (nrbits $ (div x 2))
       
main = do  
  args <- getArgs
  putStrLn $ show $ sum $ map nrbits [1..(read (args !! 0)::Int)]

