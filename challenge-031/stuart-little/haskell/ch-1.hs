#!/usr/bin/env runghc

-- run <script> <numerator> <denominator>

import Data.List (isSuffixOf,)
import System.Environment (getArgs,)

main = do
  (num:den:_) <- getArgs >>= return.(map (read::String->Float))
  putStrLn $ (\w -> if isSuffixOf "Infinity" w then "You divided by zero." else w) $ show $ (/) num den
