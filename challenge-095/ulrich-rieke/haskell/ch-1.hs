module Challenge095
  where

isPalindrome :: Int -> Bool
isPalindrome n = numstr == reverse numstr
  where
      numstr :: String
      numstr = show n

solution :: Int -> Int
solution n
  |isPalindrome n = 1
  |otherwise      = 0
