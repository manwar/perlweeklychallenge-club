#!/usr/bin/env runghc

-- run <script> <x1 y1 x2 y2 x3 y3>

import System.Environment (getArgs)

areaTr :: Float -> Float -> Float -> Float -> Float -> Float -> Float
areaTr x1 y1 x2 y2 x3 y3 = flip (/) 2 $ abs $ ((y3-y1)*(x2-x1) - (y2-y1)*(x3-x1))

main = do
  (x1:y1:x2:y2:x3:y3:_) <- getArgs >>= return . map (read::String->Float)
  print $ fromEnum $ (areaTr 0 0 x1 y1 x2 y2) + (areaTr 0 0 x2 y2 x3 y3) + (areaTr 0 0 x3 y3 x1 y1) == (areaTr x1 y1 x2 y2 x3 y3)
