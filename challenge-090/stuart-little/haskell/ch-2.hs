#!/usr/bin/env runghc

-- run as <script> <space-separated numbers>

import System.Environment

ethMultProc a b acc
  |a==1 = (a,b):acc
  |otherwise = ethMultProc (div a 2) (b*2) ((a,b):acc)
       
main = do  
  args <- getArgs
  let nra:nrb:_ = map (read::String->Int) $ args
      steps = ethMultProc nra nrb []
  putStrLn "\nSequence of steps:"
  mapM_ putStrLn $ map show $ reverse steps
  putStrLn "\nResult:"
  putStrLn $ show $ sum $ map snd $ filter (odd . fst) $ steps
