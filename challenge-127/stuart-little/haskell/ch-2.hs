#!/usr/bin/env runghc

-- run <script> <left1 right1 left2 right2 ...>

import Data.List (tails, nub)
import Data.List.Split (chunksOf)
import System.Environment (getArgs)

main :: IO ()
main = getArgs >>= putStrLn . unlines . map unwords . map (map show) . nub . map snd . filter (\(x,y)-> (y!!1 - x!!0)*(y!!0 - x!!1) <= 0) . (\xs-> [(x, y) | (x:ys) <- tails (nub xs), y <- ys]) . chunksOf 2 . map (read::String->Int)
