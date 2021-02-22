#!/usr/bin/env runghc

-- run <script> <number to get or nothing to default to 200>

import Data.List.Extra (headDef,)
import System.Environment (getArgs,)

doubleOrAdd1 :: Int -> [Int]
doubleOrAdd1 nr
  |nr==1 =[1]
  |even nr = nr:(doubleOrAdd1 $ div nr 2)
  |odd nr = nr:(doubleOrAdd1 $ (-) nr 1)

main = do
  nr <- getArgs >>= return.(read::String->Int).(headDef "200")
  print $ reverse $ doubleOrAdd1 nr
