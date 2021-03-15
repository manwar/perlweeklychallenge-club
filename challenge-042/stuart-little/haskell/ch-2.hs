#!/usr/bin/env runghc

-- run <script> <quoted string of parentheses or nothing; if you provide nothing a string will be generated randomly>

import System.Environment (getArgs,)
import Data.List (inits,)
import Data.List.Extra (lastDef,headDef,)
import System.Random (getStdGen,randomRIO,randomRs,)

validate str =
  let f '(' = 1; f ')' = -1; g x = map sum $ (map.map) f $ inits x
  in ((lastDef 0 $ g str) == 0) && (all (0<=) $ g str)

main = do
  args <- getArgs
  nrchars <- randomRIO (1::Int,50)
  gen <- getStdGen  
  let strng = headDef (take (nrchars) (randomRs ('(',')') gen)) args
  putStrLn ("Your string: " ++ strng)
  putStrLn $ show $ validate strng
