#!/usr/bin/env runghc

-- run <script> <time in hh:mm format, followed by am/pm if desired>

import Data.Char (isDigit,toLower)
import Data.List (isInfixOf)
import Data.List.Split (splitOn)
import System.Environment (getArgs)
import Text.Printf (printf)

fmTime :: String -> Int -> Int -> String
fmTime mode h m
  |isInfixOf "am" $ map toLower mode = (printf "%02d" (mod h 12)) ++ ":" ++ (printf "%02d" m)
  |isInfixOf "pm" $ map toLower mode = (printf "%02d" ((mod h 12)+12)) ++ ":" ++ (printf "%02d" m)
  |otherwise = (printf "%02d" modh) ++ ":" ++ (printf "%02d" m) ++ mer where
     mer = if elem h [0..11] then " am" else " pm"
     modh = if elem h [1..12] then h else (mod (h-12) 24)

main = do
  (hh:rest:_) <- getArgs >>= return . splitOn ":" . unwords
  let h = (read::String->Int) hh
      (m,mode) = (\(x,y) -> ((read::String->Int) x, y)) $ span isDigit rest
  putStrLn $ fmTime mode h m
