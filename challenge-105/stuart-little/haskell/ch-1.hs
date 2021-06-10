#!/usr/bin/env runghc

-- run <script> <exponent> <number>

import System.Environment (getArgs)

nthRoot :: Int -> Int -> Double
nthRoot xp nr = let rootFloor = head $ dropWhile (\x -> (x+1)^xp <= nr) [1..] in
  if (rootFloor ^ xp == nr) then fromIntegral rootFloor
  else exp (((log $ fromIntegral nr))/(fromIntegral xp))

main = do
  (xp:nr:_) <- getArgs >>= return . map (read::String->Int)
  print $ nthRoot xp nr
