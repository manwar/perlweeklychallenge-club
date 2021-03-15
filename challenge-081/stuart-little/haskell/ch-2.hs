#!/usr/bin/env runghc

-- run <script> <file-path>

import Data.List.Extra (groupSortOn,)
import Data.List.Extra (replace,)
import System.Environment (getArgs,)

main = do
  txt <- getArgs >>= return.head >>= readFile >>= return.(filter (flip notElem ".\"(),")) >>= return.(replace "'s" "").(replace "--" " ")
  mapM_ print $ map (\l -> let (ls,ws) = unzip l in (head ls,ws)) $ groupSortOn fst $ map (\l -> (length l, head l)) $ groupSortOn id $ words txt
