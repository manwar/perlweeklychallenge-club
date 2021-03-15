#!/usr/bin/env runghc

-- run <script> <space-separated list of file_paths>

import System.Environment (getArgs,)
import Control.Monad (liftM,)
import Data.Maybe (fromJust,)
import Data.List.Unique (sortUniq,)

main = do
  files <- getArgs
  texts <- mapM ((liftM words).readFile) files
  let wrds = sortUniq $ concat texts
  let idx = zip files texts
  let invidx = zip wrds $ map (\w -> filter (\fl -> elem w $ fromJust $ lookup fl idx) files) wrds
  mapM_ putStrLn $ map (\(x,y) -> (show x) ++ " appears in: " ++ (unwords y)) $ invidx
