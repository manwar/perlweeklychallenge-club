module Challenge147
  where

isPrime :: Int -> Bool
isPrime n
  |n == 1 = False
  |n == 2 = True
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. root]
  where
      root :: Int
      root = round $ sqrt $ fromIntegral n

isTruncatablePrime :: Int -> Bool
isTruncatablePrime n = (not $ elem '0' nstring) && all isPrime theList
  where
      l :: Int
      l = length nstring
      nstring :: String
      nstring = show n
      theList :: [Int]
      theList = map (\i -> read $ drop i nstring) [0 .. l - 1]

solution :: [Int]
solution = take 20 $ filter isTruncatablePrime [1 , 2 ..]
