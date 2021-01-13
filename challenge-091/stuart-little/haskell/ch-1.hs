#!/usr/bin/env runghc

-- run as <script> <number>

import System.Environment   
import Data.List  

freqs s = concat $ map (\x -> (show $ length x) ++ [head x]) $ group s
        
main = do  
  args <- getArgs
  putStrLn $ freqs $ head args
