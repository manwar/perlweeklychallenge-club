#!/usr/bin/env runghc

-- run <script> <time>

import Data.List.Split (splitOn)
import System.Environment (getArgs)

angl :: Double -> Double -> Double
angl h m = min rawDiff $ 360-rawDiff where
  rawDiff = abs ((fromIntegral (mod (round h) 12)*30) + m/2 - m * 6)

main = do
  [h,m] <- getArgs >>= return . map (read::String->Double) . splitOn ":" . head
  putStrLn $ show $ angl h m
