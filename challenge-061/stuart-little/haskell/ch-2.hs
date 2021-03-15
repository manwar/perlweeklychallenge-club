#!/usr/bin/env runghc

-- run <script> <string>

{-# LANGUAGE PackageImports #-}

import "ghc" Util (nTimes,)
import Control.Monad ()
import Data.List ((\\),isPrefixOf,)
import Data.List.Extra (notNull,)
import Data.List.Utils (join,)
import Safe (initSafe,)
import System.Environment (getArgs,)

splitPrefsHelper :: [String] -> String -> [[String]]
splitPrefsHelper prefs str = map (\p-> [p,str\\p]) $ filter (flip isPrefixOf str) prefs

splitPrefs :: [String] -> [[String]] -> [[String]]
splitPrefs prefs ls = filter notNull $ concat $ map (\l -> map ((init l) ++) $ splitPrefsHelper prefs $ last l) ls

main = do
  ip <- getArgs >>= return.head
  mapM_ putStrLn $ map (join ".") $ map initSafe $ filter (null.last) $ nTimes 4 (splitPrefs prefs) [[ip]] where
    prefs = map show [0..255]
