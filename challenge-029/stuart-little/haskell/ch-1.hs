#!/usr/bin/env runghc

-- run <script> <space-separated strings, with no whitespace between braces>

import System.Environment (getArgs,)
import Data.List.Extra (notNull,)
import Data.List.Split (splitOneOf,)

main = do
  wordchains <- getArgs >>= return.(map ((filter notNull).(splitOneOf "{,}")))
  mapM_ putStrLn $ map unwords $ sequence wordchains
