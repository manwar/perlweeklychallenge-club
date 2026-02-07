module Main where

import           Control.Exception (assert, evaluate)
import           Data.List         (group)

solve :: String -> String
solve s = solve' s (dedup s)
  where
    solve' s s' | length s == length s' = s
    solve' _ s' = solve' s' (dedup s')

    dedup = map head . filter ((==1) . length) . group

main :: IO ()
main = do
  evaluate $ assert ("" == solve "aabbccdd") ()
  evaluate $ assert ("" == solve "abccba") ()
  evaluate $ assert ("abcdef" == solve "abcdef") ()
  evaluate $ assert ("aea" == solve "aabbaeaccdd") ()
  evaluate $ assert ("m" == solve "mississippi") ()
