#!/usr/bin/env runghc

-- run <script> <path-to-dict-file, one word per line>

import Control.Monad (liftM)
import Data.Char (toLower)
import Data.List.Extra (groupSortOn)
import Data.List.Ordered (isSorted)
import System.Environment (getArgs)

longestSorted :: [String] -> [String]
longestSorted wrds = head . groupSortOn (((-1)*) . length) . filter (isSorted . map toLower) $ wrds

main = do
  wrds <- getArgs >>= (liftM lines) . readFile . head 
  putStrLn . unlines . longestSorted $ wrds
