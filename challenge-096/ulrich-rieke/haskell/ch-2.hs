module Challenge096_2
  where

levenshtein_distance :: String -> String -> Int
levenshtein_distance a b
  |null a = length b
  |null b = length a
  |head a == head b = levenshtein_distance ( tail a ) ( tail b )
  |otherwise = 1 + minimum [levenshtein_distance a ( tail b ) ,
    levenshtein_distance ( tail a ) b , levenshtein_distance ( tail a ) ( tail b )]
