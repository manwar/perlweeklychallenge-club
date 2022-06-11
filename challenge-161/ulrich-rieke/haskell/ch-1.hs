module Challenge161
  where
import Data.List ( sortBy , sort )

isAbecedarian :: String -> Bool
isAbecedarian s = s == sort s

mySorter :: String -> String -> Ordering
mySorter s1 s2
  |length s1 > length s2 = LT
  |length s1 == length s2 = EQ
  |length s1 < length s2 = GT

main :: IO ( )
main = do
  fileAsString <- readFile "dictionary.txt"
  let allWords = words fileAsString
      abecedarians = filter isAbecedarian allWords
      sorted = sortBy mySorter abecedarians
  print sorted
