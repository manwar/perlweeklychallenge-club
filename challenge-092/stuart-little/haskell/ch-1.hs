#!/usr/bin/env runghc

-- run as <script> <space-separated strings>

import System.Environment   
import Data.List  

freqs :: Ord a => [a] -> [Int]
freqs = (map length).group.sort

isop x y = ((freqs x == freqs z) && (freqs y == freqs z'))
  where z=zip x y
        z'=zip y x
        
main = do  
  args <- getArgs
  putStrLn $ show $ isop (args !! 0) (args !! 1)  
