module Challenge155
  where
import Data.List ( nub , sort )

isPrime :: Int -> Bool
isPrime n
  |n == 2 = True
  |n == 1 = False
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. root]
  where
      root :: Int
      root = floor $ sqrt $ fromIntegral n

primeNumbers :: [Int]
primeNumbers = take 11 $ filter isPrime [2 .. ]

primorials :: [Int]
primorials = [2] ++ map (\i -> product $ take i primeNumbers ) [2 .. 11]

solution :: [Int]
solution = take 8 $ nub $ sort $ map myFunc primorials
  where
      myFunc :: Int -> Int
      myFunc n = (until isPrime ( + 1 ) ( n + 2 )) - n
