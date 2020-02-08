module Challenge046
  where
import Data.List ( transpose , nub , sortOn )

--assuming all strings of the list are of equal length

countLetters :: String -> [(Char , Int)]
countLetters word = map (\c -> (c , count c word)) $ nub word
  where
      count :: Char -> String -> Int
      count d aWord = length $ filter ( d == ) aWord

decode :: [String] -> String
decode stringlist =
  let columns = transpose stringlist
  in map ( fst . last ) $ map (\wo -> sortOn snd wo)  $ map countLetters columns
