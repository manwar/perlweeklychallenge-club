import Data.Char (isAlpha)
import Data.Function (on)
import Data.List (concat, groupBy, unlines)

inputs =
  [ "I love Perl",
    "Perl and Raku are friends",
    "The Weekly Challenge",
    "Perl! and Raku?     are... friends>",
    "But, Haskell has dignity, and like, mathematical rigor or something"
  ]

chaffed_words = map goatifyString inputs

main = putStr $ unlines chaffed_words

isVowel :: Char -> Bool
isVowel = flip elem "AEIOUaeiouy"

goatifyWord :: String -> Int -> String
goatifyWord word count
  | isVowel $ word !! 0 =
      word ++ "ma" ++ (concat $ take count $ repeat "a")
  | isAlpha $ word !! 0 =
      (tail word) ++ [word !! 0] ++ "ma" ++ (concat $ take count $ repeat "a")
  | otherwise = word

goatifyString string =
  let words_list = groupBy ((==) `on` isAlpha) string
      words_index = zip words_list [2 ..]
      goated_words = map (\x -> goatifyWord (fst x) (div (snd x) 2)) words_index
   in concat goated_words
