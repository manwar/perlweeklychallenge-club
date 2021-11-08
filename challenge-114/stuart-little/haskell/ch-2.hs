#!/usr/bin/env runghc

-- run <script>

import Data.Char (digitToInt)
import Data.Digits (digits,unDigits)
import System.Environment (getArgs)
import Text.RegexPR (subRegexPR)

nxtSameNrBits :: String -> String
nxtSameNrBits binNr = if (last binNr == '1')
                      then subRegexPR "01(1*)$" "10\\1" binNr
                      else subRegexPR "01(1*)(0*)$" "10\\2\\1" binNr

main = do
  binNr <- getArgs >>= return . concat . map show . (0:) . (digits 2) . (read::String->Int) . head 
  putStrLn $ "Initial number in base two: " ++ binNr
  let nxt = nxtSameNrBits binNr
  putStrLn $ "Next number in base two: " ++ nxt
  putStrLn $ "Next number in base ten: " ++ (show . unDigits 2 . map digitToInt $ nxt)
