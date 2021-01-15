#!/usr/bin/env runghc

-- run <script> <nr of terms you want to see; nothing to default to 20>

import Data.List.Extra (headDef,)
import System.Environment (getArgs,)

outer :: Int -> Int
outer x = (read::String->Int) ((head $ show x):[(last $ show x)])

main = do
  nrterms <- getArgs >>= return.(read::String->Int).(headDef "20")
  mapM_ print $ take nrterms $ filter (\x -> mod x (outer x) == 0) [100..]
