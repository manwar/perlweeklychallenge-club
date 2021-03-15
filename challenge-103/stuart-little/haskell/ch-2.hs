#!/usr/bin/env runghc

-- run <script> <start time as unix epoch> <current time as unix epoch> <path-to-csv>

import Data.List.Split (splitOn)
import System.Environment (getArgs)

fromCSV :: String -> IO [(Integer,String)]
fromCSV pth = readFile pth >>= return . map (\(t:f:_)->((read::String->Integer) t, f)) . map (splitOn ",") . lines

totPlayTime :: [(Integer,a)] -> Integer
totPlayTime = sum . map fst

cvToTime :: Integer -> (Integer,Integer,Integer)
cvToTime millisecs = (h,m,s) where
  totSecs = round $ (fromIntegral millisecs) / 1000
  s = mod totSecs 60
  m = mod (div totSecs 60) 60
  h = div (totSecs - m*60 - s) (60^2)

whichPlaying :: Integer -> [(Integer,a)] -> a
whichPlaying tdiff files
  |tdiff <= (fst . head) files = snd $ head files
  |otherwise = whichPlaying (tdiff - (fst.head) files) $ drop 1 files

wherePlaying :: Integer -> [(Integer,a)] -> (Integer,Integer,Integer)
wherePlaying tdiff files = cvToTime $ mod tdiff $ totPlayTime files  
  
main = do
  (sinit:snow:pth:_) <- getArgs  
  files <- fromCSV pth
  let (init:now:_) = map (read::String->Integer) [sinit,snow]
      tdiff = mod (1000*(now-init)) $ totPlayTime files
      (h,m,s) = wherePlaying tdiff files
      playingFile = whichPlaying tdiff files
  putStrLn $ "\nPlaying: " ++ playingFile ++ "\n\n" ++ "At: " ++ (show h) ++ ":" ++ (show m) ++ ":" ++ (show s)
