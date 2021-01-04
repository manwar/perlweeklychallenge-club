#!/usr/bin/env runghc

-- run as <script> <number>

import System.Environment (getArgs,)

maxPowDivFact n p = sum $ map (div n) l
  where l = takeWhile (n >=) (p:(map (p*) l))
       
main = do  
  args <- getArgs
  let nr = read (args !! 0)::Int
  putStrLn $ show $ minimum $ map (maxPowDivFact nr) [2,5]

