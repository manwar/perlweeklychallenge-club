#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import System.Environment (getArgs,)
import Data.List.Extra (headDef,)
import Data.List.Utils (countElem,)

main = do
  args <- getArgs >>= return.(map (read::String->Int))
  let l = length args
  print $ headDef (-1) $ filter (\x-> (countElem x args) > (div l 2)) args
