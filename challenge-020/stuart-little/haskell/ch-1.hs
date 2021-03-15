#!/usr/bin/env runghc

-- run <script> <string>

import System.Environment (getArgs,)
import Data.List (group,)

main = do
  (str:_) <- getArgs
  print $ group str
