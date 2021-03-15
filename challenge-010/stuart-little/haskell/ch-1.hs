#!/usr/bin/env runghc

-- run <script> <number, arabic or roman; it will be converted to the other format>

import Data.Char (toUpper,)
import System.Environment (getArgs,)
import Text.Numeral.Roman (fromRoman,toRoman,)

main = do
  numeral <- getArgs >>= return . (map toUpper) . head
  let tryParseRom = fromRoman numeral
  putStrLn $ case tryParseRom of
    Nothing -> toRoman $ (read::String->Int) numeral
    Just parsed -> show parsed
