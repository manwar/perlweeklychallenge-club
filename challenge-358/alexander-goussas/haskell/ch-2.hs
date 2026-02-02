module Main where

import           Control.Exception (assert, evaluate)
import           Data.Char         (ord)

encrypt :: String -> Int -> String
encrypt s n = replace <$> s
  where
    abc = ['a'..]
    replace c = abc !! ((ord c - ord 'a' + n) `mod` 26)

main :: IO ()
main = do
  evaluate $ assert ("bcd" == encrypt "abc" 1) ()
  evaluate $ assert ("zab" == encrypt "xyz" 2) ()
  evaluate $ assert ("bcd" == encrypt "abc" 27) ()
  evaluate $ assert ("mjqqt" == encrypt "hello" 5) ()
  evaluate $ assert ("perl" == encrypt "perl" 26) ()
