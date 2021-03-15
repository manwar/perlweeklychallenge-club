#!/usr/bin/env runghc

-- run <script> <space-separated file paths>

import System.Environment (getArgs,)
import Control.Monad (liftM,)
import Data.Char (toLower,)
import Data.List.Utils (countElem,)

main = do
  files <- getArgs
  text <- liftM ((map toLower).concat) $ sequence $ map readFile files
  mapM_ putStrLn $ map (\c-> [c] ++ ": " ++ (show $ countElem c text)) ['a'..'z']
