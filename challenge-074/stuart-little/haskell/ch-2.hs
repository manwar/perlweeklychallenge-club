#!/usr/bin/env runghc

-- run <script> <string>

import System.Environment (getArgs,)
import Data.List (inits,)
import Data.List.Extra (headDef,)
import Data.List.Utils (countElem,)

main = do
  str <- getArgs >>= return.head
  print $ map (headDef '#') $ map (\l -> dropWhile (\x -> countElem x l > 1) l) $ map reverse $ tail $ inits str
