module Challenge135
  where

solution :: String -> String
solution number
  |(elem  (head number) "+-") && len == 4 = drop 1 number
  |even len = "even number of digits"
  |(len < 3 ) && (not $ even len) = "too short"
  |otherwise = take 3 $ drop ( div ( len - 3 ) 2 ) number
  where
    len :: Int
    len = length number
