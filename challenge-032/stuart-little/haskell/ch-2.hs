#!/usr/bin/env runghc

-- run <script> <flag: -l to sort by labels, -v to sort by values; defaults to values>

import Data.List (sortOn,)
import Data.List.Extra (headDef,)
import System.Environment (getArgs,)
import Text.Printf (printf,)

barGraph :: [(String,Int)] -> [String]
barGraph xs = map (\(k,v)-> (printf "%20s | " k) ++ (replicate v '#')) xs

main = do
  flag <- getArgs >>= return.(headDef "-v")
  mapM_ putStrLn $ barGraph $ sortOn (if flag == "-l" then fst else (\x -> (replicate (snd x) '0') ++ "1")) mp where
    mp = zip ["apple","cherry","banana"] [13,16,8]
