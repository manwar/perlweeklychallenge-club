#!/usr/bin/env runghc

-- run <script> <space-separated 0-1 strings, one string per row>

import System.Environment (getArgs,)

countSquares :: Eq a => a -> [[a]] -> Int
countSquares c mat = length $ filter (and.(map (c==))) $ (map.map) (\[p,q]-> mat !! p !! q) $ map (\(x,y,d)-> sequence [[x,x+d],[y,y+d]]) $ [(x,y,d) | [x,y,d] <- sequence $ replicate 3 [0..(min (length mat) (length $ head mat))], 0<d, x+d < length mat, y+d < (length $ head mat) ]

main = do
  mat <- getArgs
  print $ countSquares '1' mat
