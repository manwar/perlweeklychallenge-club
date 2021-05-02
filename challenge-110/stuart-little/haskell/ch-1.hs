#!/usr/bin/env runghc

{--
run <script> <path-to-file or nothing>
defaults to challenge sample if no file is entered
--}

import Text.Regex.PCRE ((=~),getAllTextMatches)
import System.Environment (getArgs)

defData :: String
defData = "0044 1148820341\n+44 1148820341\n44-11-4882-0341\n(44) 1148820341\n00 1148820341"

dt :: IO String
dt = do
  args <- getArgs
  if (null args) then return defData else readFile $ head args

rx :: String
rx = "(\\+\\d{2}|\\(\\d{2}\\)|\\d{4})\\s+\\d{10}"

getAllRx :: String -> [String]
getAllRx s = getAllTextMatches $ s =~ rx :: [String]

main :: IO ()
main = dt >>= (putStrLn . unlines . getAllRx)
