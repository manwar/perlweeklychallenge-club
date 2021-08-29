#!/usr/bin/env runghc

-- run <script> <space-separated set entries, with a '-' separating the two sets>

import Data.List (intersect)
import Data.List.Split (splitWhen)
import System.Environment (getArgs)

main :: IO ()
main = getArgs >>= putStrLn . show . (\[x,y]-> 1-(min 1 (length $ intersect x y))) . splitWhen ("-" ==)
