#!/usr/bin/env runghc

-- run <script> <N so as to produce S_N; defaults to N=5 if you enter nothing>

import Data.List.Extra (headDef,replace,)
import System.Environment (getArgs,)

flp :: String -> String
flp = (replace "#" "1") . (replace "1" "0") . (replace "0" "#")

iterStr :: Int -> String
iterStr n
  |n==0 =""
  |otherwise = s ++ "0" ++ (reverse $ flp s) where
     s = iterStr (n-1)

main = do
  n <- getArgs >>= return . (read::String ->Int) . (headDef "5")
  putStrLn $ iterStr n
