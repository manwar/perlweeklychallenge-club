module Main where

import           Control.Exception (assert, evaluate)
import qualified Data.Char         as Char

maxStrValue :: [String] -> Int
maxStrValue = foldl1 max . map rank
  where
    rank s | isNumericStr s = read s
    rank s = length s

    isNumericStr = all Char.isDigit

main :: IO ()
main = do
  evaluate $ assert (123 == maxStrValue ["123", "45", "6"]) ()
  evaluate $ assert (4 == maxStrValue ["abc", "de", "fghi"]) ()
  evaluate $ assert (99 == maxStrValue ["0012", "99", "a1b2c"]) ()
  evaluate $ assert (10 == maxStrValue ["x", "10", "xyz", "007"]) ()
  evaluate $ assert (2026 == maxStrValue ["hello123", "2026", "perl"]) ()
