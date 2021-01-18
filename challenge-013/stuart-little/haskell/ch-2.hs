#!/usr/bin/env runghc

-- run <script> <upper bound for argument>

import System.Environment (getArgs,)
import Control.Monad (liftM,)

fm :: Int -> Int
fm 0 = 1
fm n = n - (ml.fm) (n-1)

ml :: Int -> Int
ml 0 = 0
ml n = n - (fm.ml) (n-1)

main = do
  (nr:_) <- liftM (map (read::String->Int)) getArgs
  putStrLn ("Female: " ++ (unwords $ map (show.fm) [0..nr]))
  putStrLn ("Male: " ++ (unwords $ map (show.ml) [0..nr]))
