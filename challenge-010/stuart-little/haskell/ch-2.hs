#!/usr/bin/env runghc

-- run <script> <1st string> <2nd string>

import Data.List (inits,isPrefixOf,elemIndices,intersect,)
import Data.List.Extra (notNull,)
import System.Environment (getArgs,)

matching :: String -> String -> String
matching from to = map snd $ filter (\(i,x) -> notNull $ intersect [i-l..i+l] $ elemIndices x to) $ zip [0..] from where
  l = (div (max (length from) (length to)) 2) -1

trnsp :: String -> String -> Float
trnsp s1 s2 = flip (/) 2 $ fromIntegral $ length $ filter (\(p,q)-> p /= q) $ zip s1 s2

jSim :: String -> String -> Float
jSim s1 s2
  |m==0 =0
  |otherwise =(m/l1 + m/l2 +(m-t)/m)/3 where
     (l1:l2:_) = map (fromIntegral.length) [s1,s2]
     match1 = matching s1 s2
     match2 = matching s2 s1
     m = fromIntegral $ length match1
     t = trnsp match1 match2

jwDist :: Float -> Int -> String -> String -> Float
jwDist p n s1 s2 = (1-l*p)*(1-sim) where
  sim = jSim s1 s2
  l = fromIntegral $ min n $ (length $ takeWhile (flip isPrefixOf s2) $ inits s1) -1

main = do
  (s1:s2:_) <- getArgs
  print $ jwDist 0.1 4 s1 s2
