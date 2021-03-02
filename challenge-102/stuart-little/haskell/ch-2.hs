#!/usr/bin/env runghc

-- run <script> <number>

import System.Environment (getArgs)

hshCnt :: Int -> String
hshCnt n
  |n==0 =""
  |n==1 ="#"
  |otherwise = rest ++ stub where
     stub = (show n) ++ "#"
     rest = hshCnt $ (n-) $ length stub

main = do
  chrs <- getArgs >>= return . (read::String->Int) . head
  putStrLn $ hshCnt chrs
