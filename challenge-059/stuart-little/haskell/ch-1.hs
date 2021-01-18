#!/usr/bin/env runghc

-- run <script> <cutoff_nr> <space-separated list entries>

import System.Environment (getArgs,)
import Control.Monad (liftM,)
import Data.List (partition,)
import Data.List.Utils (join,)

main = do
  (cut:rest) <- liftM (map (read::String->Int)) getArgs
  putStrLn $ join " -> " $ map show $ uncurry (++) $ partition (cut >) rest
