module Challenge158
  where
import Data.Char ( digitToInt )

isPrime :: Integer -> Bool
isPrime n
  |n == 1 = False
  |n == 2 = True
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. toInteger root]
  where
      root :: Int
      root = round $ sqrt $ fromIntegral n

solution :: [Integer]
solution = takeWhile ( <= 100 ) $ filter (\i -> (isPrime $ digitSum i)
&& isPrime i ) [2 , 3 .. ]
  where
  digitSum :: Integer -> Integer
  digitSum n = sum $ map ( toInteger . digitToInt ) $ show n
