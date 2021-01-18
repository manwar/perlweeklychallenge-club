#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import System.Environment (getArgs,)
import Data.List (tails,inits,)
import Data.List.Extra (maximumOn,)

main = do
  nrs <- getArgs >>= return.(map (read::String->Int))
  putStrLn $ (\l -> (unwords $ map show l) ++ ";  Product: " ++ (show $ product l)) $ maximumOn product $ concat $ map tails $ inits nrs
