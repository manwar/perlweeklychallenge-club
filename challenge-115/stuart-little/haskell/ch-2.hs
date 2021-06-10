#!/usr/bin/env runghc

-- run <script> <space-separated digits>

import Data.List (intercalate,sort)
import System.Environment (getArgs)
import Text.RegexPR (subRegexPR)

lgstEven :: [String] -> String
lgstEven digs = if even.(read::String->Int) $ res then res else "No even digits.." where
  res = (subRegexPR "(.)([13579]*)$" "\\2\\1").(intercalate "").reverse.sort $ digs

main :: IO ()
main = getArgs >>= putStrLn.lgstEven 
