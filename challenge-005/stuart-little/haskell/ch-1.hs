#!/usr/bin/env runghc

-- run <script> <word> <path-to-dict-file>

import System.Environment (getArgs,)
import Data.List ((\\),)
import Data.Char (toLower,)

isAnagram :: String -> String -> Bool
isAnagram wrd1 wrd2 = (null $ uc1 \\ uc2) && (null $ uc2 \\ uc1) where
  (uc1:uc2:_) = (map.map) toLower (wrd1:[wrd2])

main = do
  (wrd:file:_) <- getArgs
  text <- readFile file
  mapM_ putStrLn $ filter (isAnagram wrd) $ words text
