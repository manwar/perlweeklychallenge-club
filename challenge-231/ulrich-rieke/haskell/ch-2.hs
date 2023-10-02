module Challenge231_2
   where

solution :: [String] -> Int
solution = length . filter isSenior
 where
  isSenior :: String -> Bool
  isSenior = ( >= 60 ) . read . take 2 . drop 11
