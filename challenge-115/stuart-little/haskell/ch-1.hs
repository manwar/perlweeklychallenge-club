#!/usr/bin/env runghc

-- run <script> <space-separated strings>

import Data.List ((\\))
import System.Environment (getArgs)

canChain :: [String] -> Char -> Char -> Bool
canChain ws s e
  |null ws = False
  |length ws == 1 = ((head.head $ ws) == s) && ((last.head $ ws) == e)
  |otherwise = any (\w -> canChain (ws \\ [w]) (last w) e) (filter (\w -> head w == s) ws)

main = do
  ws <- getArgs
  putStrLn . show . fromEnum $ (canChain (tail ws) (last . head $ ws) (head . head $ ws)) 
