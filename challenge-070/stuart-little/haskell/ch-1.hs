#!/usr/bin/env runghc

-- run <script> <string> <count> <offset>

import Data.List.Split (splitPlaces,)
import System.Environment (getArgs,)

swapChunks :: Int -> Int -> [a] -> [a]
swapChunks count offset xs
  |count+offset < ln = l0 ++ l3 ++ l2 ++ l1 ++ l4
  |count+offset == ln = m2 ++ m4 ++ m0 ++ m3 ++ m1
  where
    ln = length xs
    (l0:l1:l2:l3:l4:_) = splitPlaces [1,count,offset-count,count,ln-offset-count-1] xs
    (m0:m1:m2:m3:m4:_) = splitPlaces [1,count-1,1,offset-count,count-1] xs

main = do
  (str:rest) <- getArgs
  let (count:offset:_) = map (read::String->Int) rest
  putStrLn $ swapChunks count offset str
