#!/usr/bin/env runghc

-- run <script> <space-separated integers>

import Data.List (sort,sortOn,)
import Data.List.Extra (groupOn,)
import System.Environment (getArgs,)

main = do
  nrs <- getArgs >>= return.(map (read::String->Int))
  putStrLn $ pprnt $ snd $ unzip $ last $ sortOn length $ groupOn fst $ zipWith (\x y -> (y-x,y)) [0..] $ sort nrs where
    pprnt :: [Int] -> String
    pprnt xs
      |length xs <= 1 ="0"
      |otherwise = unwords $ map show xs
