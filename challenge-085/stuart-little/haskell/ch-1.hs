#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import Data.List (nub,)
import Data.List.Extra (notNull,)
import Math.TreeFun.Tree (boolToInt,)
import System.Environment (getArgs,)

hasTriplets12 :: [Float] -> Bool
hasTriplets12 xs = let ordxs = nub xs in notNull [(a,b,c) | a<-ordxs, b<-ordxs, c<-ordxs, a<b, b<c, 1 < a+b+c, a+b+c<2]

main = do
  nrs <- getArgs >>= return.(map (read::String->Float))
  putStrLn $ show $ boolToInt $ hasTriplets12 nrs
