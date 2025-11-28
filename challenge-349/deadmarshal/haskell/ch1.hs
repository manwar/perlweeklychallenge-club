module Ch1 where

import Data.List

powerString :: String -> Int
powerString s = maximum $ map length $ group s

main :: IO ()
main = do
   print $ powerString "textbook"
   print $ powerString "aaaaa"
   print $ powerString "hoorayyy"
   print $ powerString "x"
   print $ powerString "aabcccddeeffffghijjk"

