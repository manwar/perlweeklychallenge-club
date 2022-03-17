module Challenge154_2
  where
import Data.List ( nub , (!!) )

isPrime :: Integer -> Bool
isPrime n
  |n == 1 = False
  |n == 2 = True
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. toInteger root]
  where
      root :: Int
      root = round $ sqrt $ fromIntegral n

stepList :: [Integer] -> [Integer]
stepList triple = tail (triple ++ [(triple !! 0) + ( triple !! 1 )] )

solution :: [Integer]
solution =  nub $ take 11 $ filter isPrime $ map last $ iterate stepList [1 , 1 , 1]
