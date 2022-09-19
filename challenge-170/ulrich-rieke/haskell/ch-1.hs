module Challenge170
  where

isPrime :: Int -> Bool
isPrime n
  |n == 2 = True
  |n == 1 = False
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. root]
  where
      root :: Int
      root = floor $ sqrt $ fromIntegral n

primorials :: [Int]
primorials = map (\i -> product $ take i firstPrimes ) [1 .. 10]
where
  firstPrimes :: [Int]
  firstPrimes = [1] ++ (take 9 $ filter isPrime [2 , 3 ..])
