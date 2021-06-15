#!/usr/bin/env runghc

-- run <script> <number>
-- https://oeis.org/A006318

import System.Environment (getArgs)

memoPaths :: [[String]]
memoPaths = map mkPaths [0..]

mkPaths :: Int -> [String]
mkPaths nr
  |nr==0 = [""]
  |nr==1 = ["R","LH"]
  |otherwise = rs ++ rst where
     rs = map (('R':)) $ memoPaths !! (nr-1)
     rst = concat $ map (\x-> map (\xs-> "L" ++ (head xs) ++ "H" ++ (last xs)) $ sequence [(memoPaths !! x), (memoPaths !! (nr-1-x))]) [0..nr-1]

main :: IO ()
main = getArgs >>= putStrLn.unlines.mkPaths.(read::String->Int).head
