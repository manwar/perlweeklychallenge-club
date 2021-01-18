#!/usr/bin/env runghc

-- run <script> <integer>

import Data.Int (Int32,)
import System.Environment (getArgs,)

is32 :: Int -> Bool
is32 n = n <= bd && n >= ((-bd)-1) where
  bd = fromIntegral (maxBound::Int32)

revInt :: Int -> Int
revInt n = if (is32 res) then res else 0 where
  res = (*) (signum n) $ (read::String->Int) $ reverse $ show $ abs n
     
main = do
  nr <- getArgs >>= return.(read::String->Int).head
  putStrLn $ show $ revInt nr
