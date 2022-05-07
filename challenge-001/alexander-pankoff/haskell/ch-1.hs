module Main where

import Data.Bifunctor (first)

main :: IO ()
main = print $ replaceAndCount 'e' 'E' "Perl Weekly Challenge"

replaceAndCount :: Char -> Char -> String -> (String, Int)
replaceAndCount taret replacement = first reverse . foldl go ("", 0)
  where
    go (replaced, count) cur =
      if cur == taret
        then (replacement : replaced, succ count)
        else (cur : replaced, count)
