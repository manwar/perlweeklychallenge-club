#!/usr/bin/env runghc

-- run <script> <width> <path-to-file>

import Data.List ((\\),takeWhile,inits,)
import System.Environment (getArgs,)

lAccumChunksWhile :: Eq a => ([a] -> Bool) -> [a] -> [[a]]
lAccumChunksWhile pred lst
  |null lst = []
  |null l = []
  |otherwise = (l:(lAccumChunksWhile pred r)) where
     l = last $ takeWhile pred $ inits lst
     r = lst \\ l

wrapPar :: Int -> [String] -> [[String]]
wrapPar width = lAccumChunksWhile ((width >=).length.unwords)

main = do
  (width,path) <- getArgs >>= return.(\(x:y:_)-> (read x::Int,y))
  wrds <- readFile path >>= return.words
  mapM_ putStrLn $ map unwords $ wrapPar width wrds
