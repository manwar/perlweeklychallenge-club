#!/usr/bin/env runghc

-- run <script> <word1> <word2> <path-to-file>

import System.Environment (getArgs,)
import Data.List (delete,)
import Data.List.Extra (minimumOn,notNull,)
import Math.TreeFun.Tree (boolToInt,)
import Control.Monad (liftM,)

dist1 :: Eq a => [a] -> [a] -> Bool
dist1 xs ys = ((length xs) == (length ys)) && ((==) 1 $ sum $ map boolToInt $ zipWith (/=) xs ys)

shortestLadder :: String -> String -> [String] -> [String]
shortestLadder w1 w2 ws
  |(notElem w1 ws) || (notElem w2 ws) =[]
  |w1 == w2 =[w1]
  |otherwise = let
     wsshort = delete w1 ws
     l = map (w1:) $ filter (notNull) $ map (\w -> shortestLadder w w2 wsshort) $ filter (dist1 w1) wsshort
   in
     if (null l) then []
     else (minimumOn length l)
     
main = do
  (w1:w2:file:_) <- getArgs
  ws <- liftM words $ readFile file
  putStrLn $ unwords $ shortestLadder w1 w2 ws 
