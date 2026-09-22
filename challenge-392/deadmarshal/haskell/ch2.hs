module Ch2 where

import qualified Data.Set as Set

commonLetters :: String -> String -> Bool
commonLetters s1 s2 =
  not (Set.disjoint (Set.fromList s1) (Set.fromList s2))

wordsLengthProduct :: [String] -> Int
wordsLengthProduct ws =
  maximum (0 : [length a * length b
               | a <- ws,
                 b <- ws,
                 not(commonLetters a b)])

main :: IO ()
main = mapM_ (putStrLn . show . wordsLengthProduct)
  [
    ["a", "ab", "abc", "d", "de", "def"],
    ["a", "aa", "aaa", "aaaa"],
    ["meet", "app", "code", "sky", "bold"],
    ["a", "ab", "abc", "abcd", "efghi"],
    ["xyz", "w", "abcdefg", "hij"]
  ]

