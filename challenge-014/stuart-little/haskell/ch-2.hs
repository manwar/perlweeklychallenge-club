#!/usr/bin/env runghc

-- run <script> <path-to-dict-file>

import System.Environment (getArgs,)
import Data.Char (toUpper,)
import Data.List.Split (chunksOf,)
import Data.List.Extra (groupSortOn,)

main = do
  wrds <- getArgs >>= (readFile.head) >>= (return.words)
  putStrLn $ unwords $ last $ groupSortOn length $ filter (\w-> and $ map (flip elem states) $ chunksOf 2 $ map toUpper w) $ filter (\w -> even (length w) && length w >= 6) wrds where
    states = ["AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"]
