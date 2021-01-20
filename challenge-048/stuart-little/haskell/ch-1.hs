#!/usr/bin/env runghc

-- run <script> <nr of people; defaults to 50 if you enter nothing> 

import Data.List.Extra (headDef,)
import System.Environment (getArgs,)

surv :: Int -> Int
surv n
  |n==1 =1
  |even n = 2*(surv (div n 2)) -1
  |odd n = 2*(surv (div n 2)) +1

main = do
  nrplayers <- getArgs >>= return.(read::String->Int).(headDef "50")
  print $ surv nrplayers
