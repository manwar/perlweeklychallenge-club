module Challenge164
  where

isPrime :: Int -> Bool
isPrime n
  |n == 1 = False
  |n == 2 = True
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. root]
  where
      root :: Int
      root = round $ sqrt $ fromIntegral n

isPalindrome :: Int -> Bool
isPalindrome n = str == reverse str
where
  str :: String
  str = show n

solution :: [Int]
solution = filter (\i -> isPrime i && isPalindrome i ) [1 .. 999]
