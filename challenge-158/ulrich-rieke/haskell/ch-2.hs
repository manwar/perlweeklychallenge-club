module Challenge158_2
  where

isPrime :: Integer -> Bool
isPrime n
  |n == 1 = False
  |n == 2 = True
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. toInteger root]
  where
      root :: Int
      root = round $ sqrt $ fromIntegral n

solution :: [Integer]
solution = takeWhile ( <= 1000 ) $ filter isPrime $ map myFunc [1 , 2 ..]
where
  myFunc :: Integer -> Integer
  myFunc n = 3 * n ^ 2 + 3 * n + 1
