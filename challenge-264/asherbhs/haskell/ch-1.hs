import Data.List (partition, intersect)
import Data.Char (isUpper, toUpper)

greatestEnglishLetter :: String -> String
greatestEnglishLetter str =
  let
    (upper, lower) = partition isUpper str
    letters = intersect upper $ map toUpper lower
  in
    if null letters then "" else [maximum letters]

main :: IO ()
main = do
    print $ greatestEnglishLetter "PeRlwEeKLy"
    print $ greatestEnglishLetter "ChaLlenge"
    print $ greatestEnglishLetter "The"
