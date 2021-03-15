#!/usr/bin/env runghc

{-
run <script>

does year 2020
-}

import Data.List.Split (splitOn)
import Text.Printf (printf)

dur2020Nov :: [String]
dur2020Nov = ["9:38:01","9:34:28","9:30:57","9:27:28","9:24:01","9:20:35","9:17:11","9:13:49","9:10:30","9:07:12","9:03:57","9:00:45","8:57:35","8:54:28","8:51:23","8:48:22","8:45:23","8:42:28","8:39:36","8:36:48","8:34:03","8:31:22","8:28:45","8:26:11","8:23:42","8:21:17","8:18:57","8:16:41","8:14:29","8:12:23"]

dur2020Dec :: [String]
dur2020Dec = ["8:10:21","8:08:25","8:06:33","8:04:47","8:03:06","8:01:30","8:00:01","7:58:37","7:57:18","7:56:06","7:55:00","7:53:59","7:53:05","7:52:17","7:51:36","7:51:01","7:50:32","7:50:10","7:49:54","7:49:45","7:49:42","7:49:46","7:49:56","7:50:13","7:50:36","7:51:06","7:51:43","7:52:25","7:53:14","7:54:09","7:55:11"]

toSec :: String -> Int
toSec = sum . zipWith (*) [60^2,60,1] . map (read::String->Int) . splitOn ":"

secToHMS :: Int -> (Int,Int,Int)
secToHMS x = (h,m,s) where
  (s:m:h:_) = zipWith ($) [flip mod 60, flip mod 60,id] $ take 3 $ iterate (flip div 60) x

prHMS :: (Int,Int,Int) -> String
prHMS (h,m,s) = printf "%d hour(s), %d minute(s), %d second(s)" h m s

main = do
  let novSec = sum $ map toSec dur2020Nov
      decSec = sum $ map toSec dur2020Dec
      diff = decSec - novSec
      sgn = if diff < 0 then "-" else ""
  putStrLn "\nTotal daylight time in Nov 2020:"
  putStrLn $ prHMS $ secToHMS novSec
  putStrLn "\nTotal daylight time in Dec 2020:"
  putStrLn $ prHMS $ secToHMS decSec
  putStrLn "\nDifference:"
  putStrLn $ sgn ++ (prHMS $ secToHMS $ abs diff) 
