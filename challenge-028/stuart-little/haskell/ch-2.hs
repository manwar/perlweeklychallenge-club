#!/usr/bin/env runghc

-- run <script>

import Data.Time (getZonedTime,formatTime,defaultTimeLocale,)
import System.Console.ANSI (clearScreen,cursorUp,)
import System.Time.Extra (sleep,)

main :: IO ()
main = do
  clearScreen
  cursorUp 1
  tm <- getZonedTime
  putStrLn $ formatTime defaultTimeLocale "%T" tm
  sleep 1
  main
