#!/usr/bin/env runghc

-- run <script> <number>

import Data.Bits ((.&.))
import Data.Digits (digits,unDigits)
import Data.List.Split (chunksOf)
import System.Environment (getArgs)

toByte :: String -> [Int]
toByte nr = padding ++ unPadded where
  padding = replicate diff 0
  diff = max 0 $ 8-(length unPadded)
  unPadded = digits 2 $ ((read::String->Int) nr) .&. 255

main :: IO ()
main = getArgs >>= putStrLn.show.(unDigits 2).concat.(map reverse).(chunksOf 2).toByte.head
